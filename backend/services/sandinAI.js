/**
 * sandinAI.js — Sandin Developer Copilot (Gemini Edition)
 *
 * Powered by Google Gemini 1.5
 * Includes an Offline Static Code Analyzer (Linter) as fallback.
 */

const axios = require('axios');
const path = require('path');
const fs = require('fs');

const envManager = require('./envManager');
// ... outros requires ...

// 🚀 NOVO: Leitor nativo de .env (Zero dependências)
let localEnvApiKey = '';
try {
  const envPath = path.join(__dirname, '.env');
  if (fs.existsSync(envPath)) {
    const envData = fs.readFileSync(envPath, 'utf8');
    const match = envData.match(/SANDIN_API_KEY=(.*)/);
    if (match) localEnvApiKey = match[1].trim();
  }
} catch (e) {}

// ─── OFFLINE STATIC CODE LINTER (Fallback) ───────────────────────────────
const STATIC_CODE_RULES = [
    {
        id: 'code-async-setstate', category: 'Memory Leak Risk (setState)', severity: 'warn',
        pattern: /await\s+[^;]+;[\s\S]{1,100}setState\s*\(/i, exclude: /if\s*\(\s*!mounted\s*\)\s*return/i,
        rootCause: 'Chamada de `setState` após um `await` sem verificar se o widget ainda está na tela.',
        fix: 'Sempre adicione `if (!mounted) return;` logo após o `await`.'
    },
    {
        id: 'code-unbounded-list', category: 'Layout Break Risk (ListView)', severity: 'warn',
        pattern: /Column\s*\([\s\S]*?children\s*:\s*\[[\s\S]*?ListView\s*\(/i, exclude: /shrinkWrap\s*:\s*true|Expanded\s*\([\s\S]*?ListView/i,
        rootCause: 'Uma `ListView` dentro de uma `Column` precisa de limites de altura.',
        fix: 'Envolva a `ListView` com um `Expanded()` ou adicione `shrinkWrap: true`.'
    }
];

function analyzeWithRules(message, prompt, code) {
    const textToAnalyze = prompt || message || code || '';
    const findings = [];

    for (const rule of STATIC_CODE_RULES) {
        if (rule.pattern.test(textToAnalyze) && (!rule.exclude || !rule.exclude.test(textToAnalyze))) {
            findings.push(rule);
        }
    }

    if (findings.length === 0) {
        return {
            analysis: `## ✨ Análise Estática Concluída\n\nNenhum problema crítico estrutural foi encontrado no código submetido.`,
            findings: [], source: 'rule-based'
        };
    }

    let output = `## 🔍 Code Review: TeamSoft Linter (Offline)\n\nEncontramos **${findings.length}** pontos de atenção:\n\n`;
    findings.forEach((f, i) => {
        const icon = f.severity === 'error' ? '🔴' : '🟡';
        output += `---\n\n### ${icon} ${i + 1}. ${f.category}\n**Problema:** ${f.rootCause}\n**Como Resolver:** ${f.fix}\n\n`;
    });
    return { analysis: output, findings, source: 'rule-based' };
}


// ─── GOOGLE GEMINI COPILOT (LLM) ──────────────────────────────────────────

// Sua chave pessoal injetada para uso imediato
const apiKey = localEnvApiKey || '';

const COPILOT_SYSTEM_PROMPT = `You are Sandin, a Senior Flutter/Dart & FlutterFlow software engineer and developer copilot.

YOUR MISSION:
1. CODE ANALYSIS: Deep review of logic, performance, and memory leaks.
2. FLUTTERFLOW CONTEXT: Keep in mind the user is working inside a FlutterFlow exported project. Suggest fixes that align with FlutterFlow's state management (FFAppState, FFModel) when applicable.

RESPONSE RULES:
- Reply in Portuguese (PT-BR).
- Use structured Markdown (## for sections).
- Highlight key terms in **bold**.
- PROVIDE CONCRETE CODE SNIPPETS. Never say "do this", show the exact code block refactored.
- Be direct, professional, and skip unnecessary pleasantries. Focus on the code.`;

async function analyzeWithGemini(apiKey, prompt, message, code, onChunk) {
    const userContent = prompt || message || code || 'Faça um Code Review do código fornecido.';
    const actualKey = apiKey && apiKey.startsWith('AIza') ? apiKey : DEFAULT_GEMINI_KEY;

    // URL usando SSE (Server-Sent Events) para Streaming em Tempo Real
    const url = `https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:streamGenerateContent?alt=sse&key=${actualKey}`;

    const payload = {
        systemInstruction: { parts: [{ text: COPILOT_SYSTEM_PROMPT }] },
        contents: [{ role: "user", parts: [{ text: userContent }] }]
    };

    const response = await axios.post(url, payload, {
        headers: { 'Content-Type': 'application/json' },
        responseType: 'stream', // Fundamental para o efeito de "digitação"
        timeout: 30000
    });

    return new Promise((resolve, reject) => {
        response.data.on('data', chunk => {
            const lines = chunk.toString().split('\n').filter(l => l.trim() !== '');
            for (const line of lines) {
                if (line.startsWith('data: ')) {
                    const msg = line.replace(/^data: /, '');
                    if (msg.trim() === '[DONE]') continue;
                    try {
                        const parsed = JSON.parse(msg);
                        if (parsed.candidates && parsed.candidates.length > 0) {
                            const parts = parsed.candidates[0].content?.parts;
                            if (parts && parts.length > 0 && parts[0].text) {
                                // Envia o pedaço de texto gerado para a tela do Flutter
                                if (onChunk) onChunk(parts[0].text);
                            }
                        }
                    } catch (e) { /* Ignora chunks cortados no meio do caminho */ }
                }
            }
        });
        
        response.data.on('end', () => resolve({ analysis: 'Complete', source: 'gemini' }));
        response.data.on('error', reject);
    });
}

// ─── MAIN ENTRY POINT ─────────────────────────────────────────────────────
async function analyze({ message, prompt, code, logs = [], apiKey = '', onChunk }) {
    const actualKey = apiKey || DEFAULT_GEMINI_KEY;

    // 1. Tenta usar o cérebro do Gemini
    if (actualKey && actualKey.startsWith('AIza')) {
        try {
            return await analyzeWithGemini(actualKey, prompt, message, code, onChunk);
        } catch (err) {
            console.warn('[Sandin] Falha no Gemini. Caindo para o Linter Offline:', err.response?.data || err.message);
        }
    }

    // 2. Fallback: Linter Offline super rápido caso a internet/API falhe
    const rulesResult = analyzeWithRules(message, prompt, code);
    if (onChunk) onChunk(rulesResult.analysis);
    
    return rulesResult;
}

module.exports = { analyze, analyzeWithRules };