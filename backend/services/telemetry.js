/**
 * telemetry.js — V5.2 Lightweight Telemetry Service
 * (No longer uses Protobufs, purely JSON/WebSocket routing)
 */

function record(type, data) {
    // Na V5.2, o roteamento real é feito pelo Socket.IO no index.js.
    // Este arquivo serve apenas como uma interface limpa para eventos customizados futuros.
    return true;
}

module.exports = {
    record
};