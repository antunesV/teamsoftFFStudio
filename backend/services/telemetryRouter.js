/**
 * telemetryRouter.js — Normalizes Dart VM stream events into Dashboard telemetry protocol
 * V3.1 Ultra-Focus: Prioritizing System Variables (State, Auth, Actions)
 */

const fs = require('fs');
const path = require('path');
const os = require('os');
const protobuf = require('protobufjs');

class TelemetryRouter {
    constructor(emitFunction, onLog, telemetry) {
        this.emit = emitFunction;
        this.onLog = onLog || console.log;
        this.telemetry = telemetry;

        // Load Protobuf Schema for FlutterFlow Debug Data
        this.protoRoot = null;
        protobuf.load(path.join(__dirname, '../debug_panel_proto/protos/schema.proto'))
            .then(root => {
                this.protoRoot = root;
                this.onLog({ level: 'info', message: '✅ FlutterFlow Protobuf schema loaded for Page State extraction.' });
            })
            .catch(err => this.onLog({ level: 'error', message: `❌ Failed to load Protocol Buffers: ${err.message}` }));

        // Throttling Queues (V3.1 Ultra-Focus Priority)
        this.queues = {
            state: [],
            action: [],
            overlay: [],
            widget: []
        };

        this.MAX_QUEUE = 500;
        this.SPOOL_DIR = path.join(os.tmpdir(), 'ff_studio_spool');
        if (!fs.existsSync(this.SPOOL_DIR)) fs.mkdirSync(this.SPOOL_DIR, { recursive: true });

        // Start Throttling Interval (50 items / 100ms)
        this._startThrottling();
    }

    _startThrottling() {
        setInterval(() => {
            Object.keys(this.queues).forEach(qName => {
                const queue = this.queues[qName];
                if (queue.length > 0) {
                    const batch = queue.splice(0, 50);
                    batch.forEach(item => {
                        this.emit(this._getEventName(qName), item);
                    });
                }
            });
        }, 100);
    }

    _getEventName(qName) {
        const mapping = {
            state: 'state-update',
            action: 'ff-action-output',
            overlay: 'overlay-update',
            widget: 'ff-widget-update'
        };
        return mapping[qName] || qName;
    }

    _enqueue(qName, data) {
        if (!this.queues[qName]) return;

        if (this.queues[qName].length >= this.MAX_QUEUE) {
            this._spoolToDisk(qName, data);
            return;
        }

        this.queues[qName].push(data);
    }

    _spoolToDisk(qName, data) {
        const filename = `spool_${qName}_${Date.now()}.json`;
        const filePath = path.join(this.SPOOL_DIR, filename);
        try {
            fs.writeFileSync(filePath, JSON.stringify(data));
            this.onLog({ level: 'warn', message: `[Queue Overflow] Spooled ${qName} to disk: ${filename}` });
        } catch (err) {
            this.onLog({ level: 'error', message: `Disk spooling failed: ${err.message}` });
        }
    }

    routeEvent(streamId, event) {
        try {
            // Priority 0: Official FlutterFlow Debug Panel telemetry (Page State & Global Properties)
            if (streamId === 'Extension' && event.extensionKind === 'ext.flutterflow_debug_panel.updateDebugData') {
                const extData = event.extensionData || {};
                // More robust extraction of the actual JSON string
                const rawData = extData.data?.data || extData.data || (typeof extData === 'string' ? extData : null);

                if (rawData) {
                    this._handleOfficialFFDebug(rawData);
                } else {
                    console.log(`[FF DEBUG] No valid data found in extensionData. Keys: ${Object.keys(extData).join(', ')}`);
                }
                return;
            }

            // Priority 1: Teamsoft Custom Extensions (V3.1 Ultra-Focus)
            if (streamId === 'Extension' && event.extensionKind && event.extensionKind.startsWith('ext.teamsoft.ff.')) {
                console.log(`[VM EXT] ${event.extensionKind}`);
                this._handleFFExtension(event.extensionKind, event.extensionData);
                return;
            }

            // Priority 2: Injected postEvent instrumentation
            if (streamId === 'Extension' && event.extensionKind && event.extensionKind.startsWith('teamsoft.')) {
                console.log(`[TEAMSOFT EVENT] ${event.extensionKind}`);
                let extData = event.extensionData;
                if (extData && typeof extData === 'object' && extData.data) {
                    extData = extData.data;
                }
                if (typeof extData === 'string') {
                    try { extData = JSON.parse(extData); } catch (_) { }
                }
                this._handleTeamsoftExtension(event.extensionKind, extData);
                return;
            }

            // Normal VM streams
            switch (streamId) {
                case 'Logging':
                    this._handleLogging(event);
                    break;
                case 'Timeline':
                case 'Flutter.Frame':
                    this._handleFrame(event);
                    break;
            }
        } catch (err) {
            this.onLog({ level: 'error', message: `Telemetry router error: ${err.message}` });
        }
    }

    _decodeParamField(field) {
        if (!field) return null;

        // Recursively handle List types
        if (field.listValue && Array.isArray(field.listValue.values)) {
            return field.listValue.values.map(v => this._decodeParamField(v));
        }

        // Recursively handle Map/Struct types
        if (field.mapValue && field.mapValue.values) {
            const res = {};
            for (const [k, v] of Object.entries(field.mapValue.values)) {
                res[k] = this._decodeParamField(v);
            }
            return res;
        }

        const val = field.serializedValue;
        if (val === undefined || val === null) return null;

        // ParamType mapping from schema.proto
        switch (field.type) {
            case 0: // INT
            case "INT":
                return parseInt(val);
            case 1: // DOUBLE
            case "DOUBLE":
                return parseFloat(val);
            case 3: // BOOL
            case "BOOL":
                return val === 'true';
            case 10: // JSON
            case "JSON":
                try { return JSON.parse(val); } catch (_) { return val; }
            case 4: // DATE_TIME
            case "DATE_TIME":
                try {
                    const ms = parseInt(val);
                    return isNaN(ms) ? val : new Date(ms).toISOString();
                } catch (_) { return val; }
            case 2: // STRING
            case "STRING":
                return val;
            default:
                return val;
        }
    }

    _handleOfficialFFDebug(rawJsonString) {
        if (!rawJsonString || !this.protoRoot) return;
        try {
            const parsed = JSON.parse(rawJsonString);
            if (parsed.event_type !== 'variable') return;

            const base64Data = parsed.data;
            if (!base64Data) return;
            const buffer = Buffer.from(base64Data, 'base64');
            const ts = Date.now();

            if (parsed.data_source === 'appState' || parsed.data_source === 'appConstant' ||
                parsed.data_source === 'environmentValue' || parsed.data_source === 'globalProperty' ||
                parsed.data_source === 'authenticatedUser') {

                let typeName = 'AppState';
                let protoType = 'schema.AppStateDebugData';

                if (parsed.data_source === 'appConstant') { typeName = 'Constants'; protoType = 'schema.AppConstantDebugData'; }
                else if (parsed.data_source === 'environmentValue') { typeName = 'EnvValues'; protoType = 'schema.EnvironmentValueDebugData'; }
                else if (parsed.data_source === 'globalProperty') { typeName = 'GlobalProps'; protoType = 'schema.GlobalPropertyDebugData'; }
                else if (parsed.data_source === 'authenticatedUser') { typeName = 'Auth'; protoType = 'schema.AuthenticatedUserDebugData'; }

                const MessageType = this.protoRoot.lookupType(protoType);
                const decoded = MessageType.decode(buffer);
                const obj = MessageType.toObject(decoded, { defaults: true });

                let flatVars = {};
                // The schema shows MapDebugDataField uses a 'values' map
                const valuesMap = obj.values || {};
                for (const [k, v] of Object.entries(valuesMap)) {
                    flatVars[k] = this._decodeParamField(v);
                }

                const count = Object.keys(flatVars).length;
                if (count > 0) {
                    this._enqueue('state', { type: typeName, variables: flatVars, timestamp: ts });
                }
            }
            else if (parsed.data_source === 'widgetClass') {
                const MessageType = this.protoRoot.lookupType('schema.WidgetClassDebugData');
                const decoded = MessageType.decode(buffer);
                const obj = MessageType.toObject(decoded, { defaults: true });

                let pageVars = {};
                const pageName = obj.widgetClassName || 'Page';

                for (const [k, v] of Object.entries(obj.widgetParameters || {})) {
                    pageVars[`[Param] ${k}`] = this._decodeParamField(v);
                }
                for (const [k, v] of Object.entries(obj.localStates || {})) {
                    pageVars[k] = this._decodeParamField(v);
                }
                for (const [k, v] of Object.entries(obj.widgetStates || {})) {
                    pageVars[`[Widget] ${k}`] = this._decodeParamField(v);
                }
                for (const [k, v] of Object.entries(obj.actionOutputs || {})) {
                    pageVars[`[Action] ${k}`] = this._decodeParamField(v);
                }
                for (const [k, v] of Object.entries(obj.generatorVariables || {})) {
                    pageVars[`[Gen] ${k}`] = this._decodeParamField(v);
                }
                for (const [k, v] of Object.entries(obj.backendQueries || {})) {
                    pageVars[`[Query] ${k}`] = this._decodeParamField(v);
                }

                if (Object.keys(pageVars).length > 0) {
                    this._enqueue('state', { type: 'PageState', variables: pageVars, page: pageName, timestamp: ts });
                }
            }
        } catch (e) {
            this.onLog({ level: 'error', message: `❌ Protobuf Decode Error: ${e.message}` });
        }
    }

    _handleFFExtension(kind, data) {
        const timestamp = Date.now();
        const payload = { ...data, timestamp };
        console.log(`[VM EXT] Normalizing: ${kind} - Data: ${JSON.stringify(data).slice(0, 200)}`);

        if (kind.includes('getState')) this._enqueue('state', payload);
        if (kind.includes('getGlobalProps')) this._enqueue('state', { ...payload, type: 'GlobalProps' });
        if (kind.includes('actionOutput')) this._enqueue('action', payload);
        if (kind.includes('getWidgetTree')) this._enqueue('widget', payload);
        if (kind.includes('getOverlay')) this._enqueue('overlay', payload);
    }

    _handleTeamsoftExtension(kind, data) {
        const timestamp = Date.now();
        console.log(`[TeamSoft Event] Processing: ${kind} - Data: ${JSON.stringify(data).slice(0, 200)}`);

        switch (kind) {
            case 'teamsoft.state':
                let finalVars = data.variables || data;
                if (data.key !== undefined && data.value !== undefined) {
                    finalVars = { [data.key]: data.value };
                }
                const type = data.type || 'AppState';
                console.log(`[TeamSoft State] Type: ${type}, Vars count: ${Object.keys(finalVars).length}`);
                this._enqueue('state', { type, variables: finalVars, timestamp });
                break;
            case 'teamsoft.action':
                this._enqueue('action', { actionName: data.action, result: data.output, timestamp });
                break;
            case 'teamsoft.widget':
                this._enqueue('widget', { ...data, timestamp });
                break;
            case 'teamsoft.navigation':
                this.emit('ff-navigation', { ...data, timestamp });
                break;
            case 'teamsoft.network':
                this.emit('ff-network-call', { ...data, timestamp });
                break;
        }
    }

    _handleLogging(event) {
        // Forward critical logs immediately
        if (!event.logRecord || !event.logRecord.message) return;
        this.emit('log', { message: event.logRecord.message.valueAsString, timestamp: Date.now() });
    }

    _handleFrame(event) {
        // Frames are pushed to a hidden 'perf' queue or emitted if low frequency
        // For V3.1 Ultra-Focus, we can ignore or prioritize as needed
    }
}

module.exports = TelemetryRouter;
