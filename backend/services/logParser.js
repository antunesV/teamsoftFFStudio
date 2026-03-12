/**
 * logParser.js — Classify log lines, extract DevTools URL, detect special events & telemetry
 */

const DEVTOOLS_PATTERNS = [
    /Flutter DevTools.*?available at:\s*(http\S+)/i,
    /Dart DevTools.*?available at:\s*(http\S+)/i,
    /debugger and profiler on Chrome.*?available at:\s*(http\S+)/i,
    /(http:\/\/127\.0\.0\.1:\d+[^\s]*vsDebugSessionId[^\s]*)/,
    /(http:\/\/127\.0\.0\.1:\d+[^\s]*)/
];

// Extracts the dynamic debug service WebSocket port produced by "flutter run"
// e.g. "Debug service listening on ws://127.0.0.1:58536/2Wqx2.../ws"
const DEBUG_SERVICE_PATTERN = /Debug service listening on (ws:\/\/127\.0\.0\.1:(\d+)\/\S+\/ws)/i;

// Supabase PostgREST calls that may appear in Flutter logs when instrumented
const SUPABASE_LOG_PATTERN = /\[Supabase\]\s*(\w+)\s+on\s+(\S+)\s*\|\s*(\d+)ms/i;

const LEVEL_PATTERNS = [
    { level: 'error', patterns: [/\berror\b/i, /\bexception\b/i, /\bfailed\b/i, /\bcrash\b/i, /❌/] },
    { level: 'warn', patterns: [/\bwarning\b/i, /\bwarn\b/i, /\bdeprecated\b/i, /⚠️/] },
    { level: 'debug', patterns: [/\bdebug\b/i, /debugPrint/i, /\[AppState\]/i, /\[ApiManager\]/i, /\[WidgetTree\]/i] },
    { level: 'verbose', patterns: [/^I\/flutter\b/, /^D\/flutter\b/, /^V\//] },
];

const APPSTATE_PATTERN = /\[AppState\]\s*(\w+)\s*=\s*(.+)/;
const APIMANAGER_PATTERN = /\[ApiManager\]\s*(\w+)\s+(https?:\/\/\S+)\s*\|\s*status:\s*(\d+)\s*\|\s*([\d.]+)ms/i;
const WIDGET_PATTERN = /\[WidgetTree\]\s*(\w+)\s+built/i;
const NAV_PATTERN = /\[Navigation\]\s*(PUSH|POP)\s+(.*)/i;
const ACTION_PATTERN = /\[ActionOutput\]\s*(\w+)=(.+)/i;
const FRAME_TIME_PATTERN = /frame time:\s*([\d.]+)ms/i;
const MEMORY_PATTERN = /memory overflow|OOM|OutOfMemoryError/i; // Basic leak detection string

function detectLevel(line) {
    for (const { level, patterns } of LEVEL_PATTERNS) {
        for (const pattern of patterns) {
            if (pattern.test(line)) return level;
        }
    }
    return 'info';
}

function extractDevToolsUrl(line) {
    for (const pattern of DEVTOOLS_PATTERNS) {
        const match = line.match(pattern);
        if (match) return match[1] || match[0];
    }
    return null;
}

function parseAppState(line) {
    const match = line.match(APPSTATE_PATTERN);
    if (!match) return null;
    return { key: match[1], value: match[2].trim() };
}

function parseApiCall(line) {
    const match = line.match(APIMANAGER_PATTERN);
    if (!match) return null;
    return {
        method: match[1],
        endpoint: match[2],
        status: parseInt(match[3], 10),
        duration: parseFloat(match[4])
    };
}

function parseWidgetUpdate(line) {
    const match = line.match(WIDGET_PATTERN);
    if (!match) return null;
    return { widget: match[1] };
}

function parseNavigationChange(line) {
    const match = line.match(NAV_PATTERN);
    if (!match) return null;
    return { action: match[1].toUpperCase(), route: match[2].trim() };
}

function parseActionOutput(line) {
    const match = line.match(ACTION_PATTERN);
    if (!match) return null;
    let resultJson = match[2].trim();
    try {
        resultJson = JSON.parse(resultJson);
    } catch (e) { }
    return { actionName: match[1], result: resultJson };
}

function parseFrameTime(line) {
    const match = line.match(FRAME_TIME_PATTERN);
    if (!match) return null;
    return { durationMs: parseFloat(match[1]) };
}

function detectMemoryLeak(line) {
    return MEMORY_PATTERN.test(line);
}

/**
 * Extracts the Flutter debug service WebSocket URL and port.
 * Returns { wsUrl, port } or null.
 */
function parseDebugServicePort(line) {
    const match = line.match(DEBUG_SERVICE_PATTERN);
    if (!match) return null;
    return {
        wsUrl: match[1],
        port: parseInt(match[2], 10)
    };
}

/**
 * Extracts Supabase query events from instrumented Flutter logs.
 * Format: [Supabase] SELECT on users | 42ms
 */
function parseSupabaseQuery(line) {
    const match = line.match(SUPABASE_LOG_PATTERN);
    if (!match) return null;
    return {
        operation: match[1].toUpperCase(),
        table: match[2],
        duration: parseInt(match[3], 10)
    };
}

function parseLine(raw) {
    const line = raw.toString().replace(/\r?\n$/, '');
    const timestamp = Date.now();
    const result = {
        level: detectLevel(line),
        message: line,
        timestamp
    };

    const devToolsUrl = extractDevToolsUrl(line);
    if (devToolsUrl) result.devToolsUrl = devToolsUrl;

    const appState = parseAppState(line);
    if (appState) {
        result.appState = appState;
        result.appState.timestamp = timestamp;
    }

    const apiCall = parseApiCall(line);
    if (apiCall) {
        result.apiCall = apiCall;
        result.apiCall.timestamp = timestamp;
    }

    const widgetUpdate = parseWidgetUpdate(line);
    if (widgetUpdate) {
        result.widgetUpdate = widgetUpdate;
        result.widgetUpdate.timestamp = timestamp;
    }

    const navigationChange = parseNavigationChange(line);
    if (navigationChange) {
        result.navigationChange = navigationChange;
        result.navigationChange.timestamp = timestamp;
    }

    const actionOutput = parseActionOutput(line);
    if (actionOutput) {
        result.actionOutput = actionOutput;
        result.actionOutput.timestamp = timestamp;
    }

    const frameTime = parseFrameTime(line);
    if (frameTime) {
        result.frameTime = frameTime;
        result.frameTime.timestamp = timestamp;
    }

    if (detectMemoryLeak(line)) {
        result.memoryIssue = true;
    }

    return result;
}

module.exports = { parseLine, detectLevel, extractDevToolsUrl, parseAppState, parseApiCall, parseWidgetUpdate, parseFrameTime, parseDebugServicePort, parseSupabaseQuery, DEBUG_SERVICE_PATTERN };
