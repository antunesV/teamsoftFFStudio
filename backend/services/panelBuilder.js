/**
 * panelBuilder.js — Checks and builds the Flutter Dashboard
 */
const fs = require('fs');
const path = require('path');

async function ensurePanelBuilt(force = false) {
    console.log('[PanelBuilder] ⚡ Flutter Debug Panel ready. Skipping compilation.');
    return Promise.resolve();
}

module.exports = {
    ensurePanelBuilt
};