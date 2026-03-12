# 🚀 TeamSoft FF Studio (LocalRun) - V5.2

Um ambiente de desenvolvimento local avançado e painel de depuração (Debug Dashboard) para projetos exportados do **FlutterFlow**. 

Construído para desenvolvedores que precisam de mais poder do que o "Test Mode" padrão oferece, o TeamSoft FF Studio injeta telemetria automaticamente no seu código, levanta um painel Flutter Web lindíssimo e traz um **Engenheiro de IA (Sandin Copilot)** para revisar seus Custom Codes em tempo real.

---

## ✨ Principais Funcionalidades

* 📊 **State Inspector em Tempo Real:** Esqueça os \`print()\`. Monitore \`AppState\`, \`PageState\`, \`Widget State\` e \`Action Outputs\` em tempo real enquanto navega pelo app.
* 💻 **Custom Code Explorer:** Navegue instantaneamente pelas suas *Custom Functions*, *Custom Actions* e *Custom Widgets*. 
* 🔌 **Integração com Editores:** Abra qualquer arquivo diretamente no **VS Code** ou **Cursor** com um clique no painel.
* 🤖 **Sandin AI Copilot (Powered by Gemini):** Faça análises de código (Code Review), encontre gargalos de performance e corrija bugs (NPEs, RenderFlex Overflows, Memory Leaks) diretamente no painel.
* ⚡ **Hot Reload Dinâmico:** Envie comandos de \`r\` (Reload) e \`R\` (Restart) para o emulador/Chrome sem precisar tocar no terminal.

---

## 🏗️ Arquitetura do Sistema

A arquitetura V5.2 foi desenhada para ser limpa, modular e não invasiva (não suja o seu repositório git com logs temporários).

1. **Backend (Node.js - Daemon):** Roda na porta \`3000\`. Responsável por receber o comando da CLI do FlutterFlow, baixar o código, injetar a instrumentação dinamicamente (\`logInjector.js\`) e rotear os eventos via WebSocket (\`telemetryRouter.js\`).
2. **Frontend (Flutter Web - Dashboard):** Uma interface "Glassmorphism" construída em Flutter para visualização dos dados, conectada ao backend via Socket.IO.

---

## 🛠️ Pré-requisitos

Para rodar este ambiente na sua máquina, você precisará de:
* **[Node.js](https://nodejs.org/)** (v16 ou superior)
* **[Flutter SDK](https://docs.flutter.dev/get-started/install)** (Instalado e configurado no seu PATH do sistema)
* **[FlutterFlow CLI](https://pub.dev/packages/flutterflow_cli)** (Instalado globalmente via \`dart pub global activate flutterflow_cli\`)

---

## 🚀 Como Iniciar (Getting Started)

### 1. Instalação
Clone o repositório para a sua máquina:
\`\`\`bash
git clone https://github.com/SEU_USUARIO/teamsoft-ff-localrun.git
cd teamsoft-ff-localrun
\`\`\`

### 2. Executando a Ferramenta
No Windows, basta dar um duplo clique no inicializador blindado:
\`\`\`bash
start.bat
\`\`\`
*(Ele instalará as dependências do Node automaticamente na primeira execução e iniciará o servidor na porta 3000).*

### 3. Injetando o seu Projeto
No terminal que se abrirá, cole o comando de exportação fornecido pelo painel do FlutterFlow:
\`\`\`bash
▶ Cole o comando do FlutterFlow: flutterflow export-code --project <seu-projeto> --token <seu-token>
\`\`\`

A mágica acontece aqui: A ferramenta fará o download, injetará a telemetria, fará o \`pub get\` e abrirá seu App em uma janela do Chrome, seguida pelo Dashboard de Debug em outra!

---

## 🧠 Configurando a Inteligência Artificial (Gemini)

O *Sandin AI Copilot* possui um "Linter Offline" que detecta erros estruturais básicos mesmo sem internet. Porém, para desbloquear o verdadeiro Code Review com LLM:

1. Gere uma API Key gratuita no [Google AI Studio](https://aistudio.google.com/).
2. O sistema foi pré-configurado para injetar a chave automaticamente via arquivo \`services/sandinAI.js\` ou através do \`config.json\` gerado na pasta do usuário (\`~/.teamsoft-ff-localrun/config.json\`).
3. Abra um arquivo no *Custom Code Explorer* e clique em **✨ Code Review IA**.

---

## 📂 Estrutura de Diretórios

\`\`\`text
teamsoft-ff-localrun/
├── backend/                  # Motor principal (Node.js)
│   ├── services/             # Módulos de orquestração (logInjector, sandinAI, etc.)
│   └── index.js              # Entrypoint do Servidor/CLI
├── frontend_flutter/         # Código fonte do Painel (Flutter Web)
│   ├── lib/
│   │   ├── screens/          # UI principal (Debug Panel)
│   │   └── services/         # Socket.
