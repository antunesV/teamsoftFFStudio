/**
 * vmServiceClient.js — WebSocket JSON-RPC 2.0 bridge to Dart VM Service
 */

const WebSocket = require('ws');

class VmServiceClient {
    constructor(url, onEvent, onDisconnect, onLog, onIsolateChanged) {
        this.url = url;
        this.onEvent = onEvent;
        this.onDisconnect = onDisconnect;
        this.onLog = onLog || console.log;
        this.onIsolateChanged = onIsolateChanged;

        this._msgId = 1;
        this._pendingRequests = new Map();
        this.isolateId = null;
        this.vm = null;

        try {
            this.ws = new WebSocket(url);
            this.ws.on('open', () => this._handleConnect());
            this.ws.on('message', (data) => this._handleMessage(data));
            this.ws.on('error', (err) => this.onLog({ level: 'error', message: `VM WS Error: ${err.message}` }));
            this.ws.on('close', () => {
                this.onLog({ level: 'info', message: '[VmServiceClient] WebSocket disconnected.' });
                if (this.onDisconnect) this.onDisconnect();
            });
        } catch (e) {
            this.onLog({ level: 'error', message: `VM WS Init Error: ${e.message}` });
        }
    }

    async _handleConnect() {
        this.onLog({ level: 'info', message: `Connected to Dart VM Service WebSocket at ${this.url}` });

        try {
            // Subscribe to streams
            await this.call('streamListen', { streamId: 'Logging' });
            await this.call('streamListen', { streamId: 'Isolate' });
            await this.call('streamListen', { streamId: 'Extension' });
            await this.call('streamListen', { streamId: 'Debug' });

            this.call('streamListen', { streamId: 'Flutter.Frame' }).catch(() => { });

            const vm = await this.call('getVM');
            this.vm = vm;
            this.onLog({ level: 'info', message: `VM Info: ${vm.isolates?.length || 0} isolates found.` });

            if (vm.isolates && vm.isolates.length > 0) {
                this._attachToFirstIsolate(vm.isolates);
            }
        } catch (err) {
            this.onLog({ level: 'error', message: `Failed to initialize VM streams: ${err.message}` });
        }
    }

    _attachToFirstIsolate(isolates) {
        const mainIsolate = isolates.find(i => i.name && !i.name.startsWith('vm-') && i.runnable !== false) || isolates[0];
        if (mainIsolate && mainIsolate.id !== this.isolateId) {
            const oldId = this.isolateId;
            this.isolateId = mainIsolate.id;
            this.onLog({ level: 'info', message: `Attached to Isolate: ${this.isolateId} (Prev: ${oldId}) [${mainIsolate.name}]` });
            if (this.onIsolateChanged) this.onIsolateChanged(this.isolateId);
        }
    }

    _handleMessage(data) {
        try {
            const msg = JSON.parse(data.toString());

            if (msg.id !== undefined) {
                const req = this._pendingRequests.get(msg.id);
                if (req) {
                    this._pendingRequests.delete(msg.id);
                    if (msg.error) {
                        req.reject(new Error(msg.error.message || JSON.stringify(msg.error)));
                    } else {
                        req.resolve(msg.result);
                    }
                }
                return;
            }

            if (msg.method === 'streamNotify') {
                const streamId = msg.params.streamId;
                const event = msg.params.event;

                if (streamId === 'Isolate' && event.kind === 'IsolateRunnable') {
                    this.onLog({ level: 'info', message: `Isolate detected: ${event.isolate.id} (${event.isolate.name})` });
                    this._attachToFirstIsolate([event.isolate]);
                }

                if (this.onEvent) {
                    this.onEvent(streamId, event);
                }
            }
        } catch (e) {
            // Ignora silenciosamente mensagens quebradas do Flutter
        }
    }

    call(method, params = {}) {
        return new Promise((resolve, reject) => {
            if (!this.ws || this.ws.readyState !== WebSocket.OPEN) {
                return reject(new Error('WebSocket is not open'));
            }

            const id = (this._msgId++).toString();
            this._pendingRequests.set(id, { resolve, reject });

            const payload = { jsonrpc: '2.0', method, params, id };

            this.ws.send(JSON.stringify(payload), (err) => {
                if (err) {
                    this._pendingRequests.delete(id);
                    reject(err);
                }
            });
        });
    }

    async callServiceExtension(extension, args = {}) {
        if (!this.isolateId) throw new Error('Isolate ID not known yet');
        return this.call(extension, { isolateId: this.isolateId, ...args });
    }

    close() {
        if (this.ws) {
            try { this.ws.terminate(); } catch (e) {}
            this.ws = null;
        }
    }
}

module.exports = VmServiceClient;