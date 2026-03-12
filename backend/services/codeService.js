/**
 * codeService.js — Manage listing and reading custom code files from the exported project
 */

const fs = require('fs');
const path = require('path');
const os = require('os');

const PROJECTS_DIR = path.join(os.homedir(), '.teamsoft-ff-localrun', 'projects');

/**
 * Find the most recently exported project directory
 */
function getActiveProjectDir() {
    try {
        if (!fs.existsSync(PROJECTS_DIR)) return null;
        const entries = fs.readdirSync(PROJECTS_DIR, { withFileTypes: true });

        // Priority: find main project folder, ignore dependencies/build/unknown_project
        const dirs = entries
            .filter(e => e.isDirectory() && !['dependencies', 'build', 'unknown_project'].includes(e.name))
            .map(e => ({
                name: e.name,
                path: path.join(PROJECTS_DIR, e.name),
                mtime: fs.statSync(path.join(PROJECTS_DIR, e.name)).mtimeMs
            }))
            .sort((a, b) => b.mtime - a.mtime);

        if (dirs.length === 0) return null;

        // Ensure it's the Flutter root (contains pubspec.yaml)
        function findFlutterRoot(dir, depth = 0) {
            if (depth > 2) return null;
            if (fs.existsSync(path.join(dir, 'pubspec.yaml'))) return dir;

            try {
                const subs = fs.readdirSync(dir, { withFileTypes: true })
                    .filter(e => e.isDirectory() && !['dependencies', 'build', '.dart_tool', 'web', 'android', 'ios', 'windows', 'macos', 'linux'].includes(e.name));
                for (const sub of subs) {
                    const found = findFlutterRoot(path.join(dir, sub.name), depth + 1);
                    if (found) return found;
                }
            } catch (e) { }
            return null;
        }

        // Try the most recent directories until we find a valid flutter root
        for (const dirEntry of dirs) {
            const root = findFlutterRoot(dirEntry.path);
            if (root) return root;
        }

        return dirs[0].path; // Final fallback
    } catch (e) {
        console.error('[CodeService] Error detecting project dir:', e);
        return null;
    }
}

/**
 * List custom actions, widgets, and functions
 */
function listCustomCodeFiles() {
    const root = getActiveProjectDir();
    if (!root) return { actions: [], widgets: [], functions: [], root: 'none' };

    const customDir = path.join(root, 'lib', 'custom_code');
    const result = {
        actions: [],
        widgets: [],
        functions: [],
        root: root
    };

    if (!fs.existsSync(customDir)) return result;

    const categories = {
        actions: 'actions',
        widgets: 'widgets',
        functions: 'actions' // FF often puts functions in actions or vice-versa
    };

    try {
        const types = fs.readdirSync(customDir);
        for (const type of types) {
            const typePath = path.join(customDir, type);
            if (fs.statSync(typePath).isDirectory()) {
                const files = fs.readdirSync(typePath).filter(f => f.endsWith('.dart'));
                for (const f of files) {
                    const name = f.replace('.dart', '');
                    if (type === 'actions') result.actions.push({ name, path: path.join(typePath, f) });
                    else if (type === 'widgets') result.widgets.push({ name, path: path.join(typePath, f) });
                    else if (type === 'functions') result.functions.push({ name, path: path.join(typePath, f) });
                }
            }
        }
    } catch (e) {
        console.error('[CodeService] Error listing custom code:', e);
    }

    return result;
}

function getFileContent(filePath) {
    try {
        if (fs.existsSync(filePath)) {
            return fs.readFileSync(filePath, 'utf8');
        }
        return null;
    } catch (e) {
        return null;
    }
}

module.exports = {
    getActiveProjectDir,
    listCustomCodeFiles,
    getFileContent,
    readFile: getFileContent, // Alias for API compatibility
    PROJECTS_DIR
};
