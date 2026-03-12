/**
 * telemetry.js — Unified Telemetry & In-Memory Timeline
 * Correlates logs, state mutations, network latency, memory performance, and Supabase queries.
 */

const MAX_EVENTS = 1000;
const MAX_SUPABASE = 500;

class Telemetry {
    constructor() {
        this.timeline = [];
        this.stateSnapshots = {}; // key -> [{ value, timestamp }]
        this.widgetHeatmap = {}; // widgetName -> count
        this.networkWaterfall = [];
        this.frameTimings = [];
        this.errors = [];
        this.supabaseQueries = []; // ring buffer for Supabase query events
    }

    reset() {
        this.timeline = [];
        this.stateSnapshots = {};
        this.widgetHeatmap = {};
        this.networkWaterfall = [];
        this.frameTimings = [];
        this.errors = [];
        this.supabaseQueries = [];
    }

    _addEvent(type, data) {
        const event = { type, timestamp: Date.now(), ...data };
        this.timeline.push(event);
        if (this.timeline.length > MAX_EVENTS) {
            this.timeline.shift();
        }
        return event;
    }

    log(level, message, source = 'system') {
        const event = this._addEvent('log', { level, message, source });
        if (level === 'error') {
            this.errors.push(event);
            if (this.errors.length > 200) this.errors.shift();
        }
        return event;
    }

    // Generic record method for telemetry-batch events
    record(type, data) {
        return this._addEvent(type, { data });
    }

    recordStateMutation(key, value) {
        if (!this.stateSnapshots[key]) {
            this.stateSnapshots[key] = [];
        }
        const snapshot = { value, timestamp: Date.now() };
        this.stateSnapshots[key].push(snapshot);
        if (this.stateSnapshots[key].length > 50) this.stateSnapshots[key].shift();

        return this._addEvent('state_mutation', { key, value });
    }

    recordApiCall(endpoint, method, status, duration, payload = null, response = null) {
        const call = { endpoint, method, status, duration, payload, response, timestamp: Date.now() };
        this.networkWaterfall.push(call);
        if (this.networkWaterfall.length > 500) this.networkWaterfall.shift();

        return this._addEvent('api_call', call);
    }

    recordWidgetBuild(widgetName) {
        this.widgetHeatmap[widgetName] = (this.widgetHeatmap[widgetName] || 0) + 1;
        return this._addEvent('widget_build', { widgetName });
    }

    recordNavigationAction(action, route) {
        return this._addEvent('navigation_change', { action, route });
    }

    recordActionOutput(actionName, result) {
        return this._addEvent('action_output', { actionName, result });
    }

    recordFrameTime(durationMs) {
        const frame = { durationMs, timestamp: Date.now() };
        this.frameTimings.push(frame);
        if (this.frameTimings.length > 1000) this.frameTimings.shift();
    }

    /**
     * Record a Supabase database query event.
     */
    recordSupabaseQuery(projectId, table, operation, duration, payload = null) {
        const query = {
            projectId: projectId || 'unknown',
            table: table || 'unknown',
            operation: (operation || 'QUERY').toUpperCase(),
            duration: duration || 0,
            payload,
            timestamp: Date.now()
        };
        this.supabaseQueries.unshift(query);
        if (this.supabaseQueries.length > MAX_SUPABASE) {
            this.supabaseQueries.pop();
        }

        return this._addEvent('supabase_query', query);
    }

    getReport() {
        return {
            totalEvents: this.timeline.length,
            errorsScanned: this.errors.length,
            topWidgets: Object.entries(this.widgetHeatmap)
                .sort((a, b) => b[1] - a[1])
                .slice(0, 10)
                .map(([name, count]) => ({ name, count })),
            averageFrameTime: this.frameTimings.length
                ? (this.frameTimings.reduce((sum, f) => sum + f.durationMs, 0) / this.frameTimings.length).toFixed(2)
                : 0,
            networkCalls: this.networkWaterfall.length,
            supabaseQueries: this.supabaseQueries.length
        };
    }
}

// Export singleton instance
const telemetry = new Telemetry();
module.exports = telemetry;
