import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';

/// AutoUpdater handles checking, downloading, and applying updates from GitHub Releases.
class AutoUpdater {
  // CONFIGURATION
  static const String githubUser = 'antunesV';
  static const String githubRepo = 'teamsoft-ff-localrun'; // Based on directory name observation
  static const String githubToken = ' INSIRA SEU TOKEN AQUI'; // User to fill this
  static const String currentVersion = '1.0.0'; // Should match pubspec.yaml version

  static Future<void> checkForUpdates() async {
    if (kIsWeb) return; // Auto-update not supported on web

    try {
      debugPrint('Checking for updates...');
      final response = await http.get(
        Uri.parse('https://api.github.com/repos/$githubUser/$githubRepo/releases/latest'),
        headers: {
          'Authorization': 'Bearer $githubToken',
          'Accept': 'application/vnd.github.v3+json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final String latestVersion = data['tag_name'] ?? '';
        
        debugPrint('Latest version: $latestVersion (Current: $currentVersion)');

        if (_isNewerVersion(latestVersion, currentVersion)) {
          debugPrint('A new update is available!');
          final assets = data['assets'] as List;
          final updateAsset = assets.firstWhere(
            (asset) => asset['name'] == 'app-update.zip',
            orElse: () => null,
          );

          if (updateAsset != null) {
            final String downloadUrl = updateAsset['url']; // GitHub API asset URL
            await _runUpdateProcess(downloadUrl);
          } else {
            debugPrint('No update asset (app-update.zip) found in the latest release.');
          }
        } else {
          debugPrint('Application is up to date.');
        }
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        debugPrint('GitHub API Authentication error: Check your token permissions.');
      } else {
        debugPrint('Failed to check for updates: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error during update check: $e');
    }
  }

  static bool _isNewerVersion(String latest, String current) {
    // Basic string comparison or semver-like comparison
    // GitHub tags often start with 'v'
    String cleanLatest = latest.startsWith('v') ? latest.substring(1) : latest;
    String cleanCurrent = current.startsWith('v') ? current.substring(1) : current;
    
    // In this specific case, the user mentioned tags like v2026.03.08-1756
    // lexicographical comparison might work for date-based tags, 
    // but semver is safer for standard versions.
    return cleanLatest.compareTo(cleanCurrent) > 0;
  }

  static Future<void> _runUpdateProcess(String assetUrl) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final String zipPath = '${directory.path}/app-update.zip';
      
      debugPrint('Downloading update from $assetUrl...');
      
      // Asset URL needs a specific Accept header for binary download from GitHub API
      final response = await http.get(
        Uri.parse(assetUrl),
        headers: {
          'Authorization': 'Bearer $githubToken',
          'Accept': 'application/octet-stream',
        },
      );

      if (response.statusCode == 200) {
        final File zipFile = File(zipPath);
        await zipFile.writeAsBytes(response.bodyBytes);
        debugPrint('Download complete. Extracting...');

        await _extractAndApply(zipFile, directory);
        debugPrint('Update applied successfully. Please restart the application.');
        
        // Optionally delete the zip after extraction
        if (await zipFile.exists()) {
          await zipFile.delete();
        }
      } else {
        debugPrint('Failed to download update: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error during update download/extraction: $e');
    }
  }

  static Future<void> _extractAndApply(File zipFile, Directory targetDir) async {
    final bytes = await zipFile.readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);

    for (final file in archive) {
      final String filename = file.name;
      if (file.isFile) {
        final data = file.content as List<int>;
        final File outFile = File('${targetDir.path}/$filename');
        await outFile.create(recursive: true);
        await outFile.writeAsBytes(data);
      } else {
        await Directory('${targetDir.path}/$filename').create(recursive: true);
      }
    }
  }
}
