/**
 * localProjectScanner.js — Scan FlutterFlow AppData directories for local projects
 */

const fs = require('fs');
const path = require('path');
const os = require('os');

const IS_WIN = process.platform === 'win32';
const IS_MAC = process.platform === 'darwin';

function getFlutterFlowRoots() {
    const roots = [];
    if (IS_WIN) {
        roots.push(path.join(os.homedir(), 'AppData', 'Roaming', 'FlutterFlow', 'flutterflow'));
        roots.push(path.join(os.homedir(), 'AppData', 'Local', 'FlutterFlow'));
    } else if (IS_MAC) {
        roots.push(path.join(os.homedir(), 'Library', 'Application Support', 'FlutterFlow', 'flutterflow'));
        roots.push(path.join(os.homedir(), 'Library', 'Application Support', 'FlutterFlow'));
    } else {
        roots.push(path.join(os.homedir(), '.local', 'share', 'FlutterFlow', 'flutterflow'));
        roots.push(path.join(os.homedir(), '.config', 'FlutterFlow'));
    }
    // Also scan teamsoft projects dir
    roots.push(path.join(os.homedir(), '.teamsoft-ff-localrun', 'projects'));
    return roots;
}

/**
 * Check if a directory looks like a Flutter project.
 */
function isFlutterProject(dir) {
    return fs.existsSync(path.join(dir, 'pubspec.yaml'));
}

/**
 * Recursively find Flutter projects up to maxDepth levels deep.
 */
function findProjects(rootDir, maxDepth = 2) {
    const projects = [];
    if (!fs.existsSync(rootDir)) return projects;

    function walk(dir, depth) {
        if (depth < 0) return;
        let entries;
        try { entries = fs.readdirSync(dir, { withFileTypes: true }); }
        catch (e) { return; }

        for (const entry of entries) {
            if (!entry.isDirectory()) continue;
            if (['flutter', '.dart_tool', 'build', '.git', 'node_modules'].includes(entry.name)) continue;

            const full = path.join(dir, entry.name);
            if (isFlutterProject(full)) {
                const stat = fs.statSync(full);
                projects.push({
                    name: entry.name,
                    path: full,
                    lastModified: stat.mtime.toISOString(),
                    lastModifiedMs: stat.mtimeMs
                });
            } else {
                walk(full, depth - 1);
            }
        }
    }

    walk(rootDir, maxDepth);
    return projects;
}

/**
 * Scan all known FlutterFlow directories for local projects.
 */
async function scan() {
    const roots = getFlutterFlowRoots();
    const allProjects = [];
    const seen = new Set();

    for (const root of roots) {
        const found = findProjects(root);
        for (const p of found) {
            if (!seen.has(p.path)) {
                seen.add(p.path);
                allProjects.push(p);
            }
        }
    }

    // Sort by most recently modified
    allProjects.sort((a, b) => b.lastModifiedMs - a.lastModifiedMs);
    return allProjects;
}

module.exports = { scan, findProjects, getFlutterFlowRoots };
