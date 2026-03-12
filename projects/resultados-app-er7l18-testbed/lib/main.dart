import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:developer' as developer;
import 'ff_studio/ff_studio_root.dart';
import 'updater.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'auth/supabase_auth/supabase_user_provider.dart';
import 'auth/supabase_auth/auth_util.dart';

import '/backend/supabase/supabase.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'package:teamsoft_library_8991ti/flutter_flow/internationalization.dart'
    as teamsoft_library_8991ti_internationalization;
import 'flutter_flow/nav/nav.dart';
import 'index.dart';

import 'package:teamsoft_library_8991ti/app_state.dart'
    as teamsoft_library_8991ti_app_state;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Check for updates asynchronously (don't block startup)
  AutoUpdater.checkForUpdates();

  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  final environmentValues = FFDevEnvironmentValues();
  await environmentValues.initialize();

  await SupaFlow.initialize();

  await FlutterFlowTheme.initialize();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  final teamsoft_library_8991tiAppState =
      teamsoft_library_8991ti_app_state.FFAppState();
  await teamsoft_library_8991tiAppState.initializePersistedState();

  _initTeamSoftExtensions();
  runApp(FFStudioRoot(child: MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => appState,
      ),
      ChangeNotifierProvider(
        create: (context) => teamsoft_library_8991tiAppState,
      ),
    ],
    child: MyApp(),
  )));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class MyAppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  String getRoute([RouteMatch? routeMatch]) {
    final RouteMatch lastMatch =
        routeMatch ?? _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }

  List<String> getRouteStack() =>
      _router.routerDelegate.currentConfiguration.matches
          .map((e) => getRoute(e))
          .toList();
  late Stream<BaseAuthUser> userStream;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = resultadosAppSupabaseUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);
      });
    jwtTokenStream.listen((_) {});
    Future.delayed(
      Duration(milliseconds: 2000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  void setLocale(String language) {
    safeSetState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Resultados - App',
      scrollBehavior: MyAppScrollBehavior(),
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        teamsoft_library_8991ti_internationalization.FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackMaterialLocalizationDelegate(),
        FallbackCupertinoLocalizationDelegate(),
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('pt'),
        Locale('en'),
        Locale('fr'),
        Locale('es'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}


// ═══════════════════════════════════════════════════════════════════════════
// TeamSoft FF Studio V3.6 — Dart VM Service Extensions (State + Tree)
// Architecture: FlutterFlow debug_panel_devtool compatible extension protocol
// ═══════════════════════════════════════════════════════════════════════════
void _initTeamSoftExtensions() {
  int _lastWidgetEmission = 0;

  // Extension: Version check
  developer.registerExtension(
    'ext.teamsoft.ff.version',
    (String method, Map<String, dynamic> params) async {
      return developer.ServiceExtensionResponse.result(jsonEncode({'version': '3.6'}));
    },
  );

  // Extension: Widget Tree Scraper (Fallback for widget values)
  developer.registerExtension(
    'ext.teamsoft.ff.getWidgetStates',
    (String method, Map<String, dynamic> params) async {
      final Map<String, String> widgetStates = {};
      try {
        void _scrape(Element element) {
          final widget = element.widget;
          String? label;
          String? value;

          if (widget is TextField) {
            label = widget.decoration?.labelText ?? widget.decoration?.hintText;
            if (widget.controller != null) {
              value = widget.controller!.text;
            }
          }

          if (value != null) {
            final key = label != null ? '[Widget] $label' : '[Widget] ${widget.runtimeType}';
            widgetStates[key] = value;
          }
          
          element.visitChildren(_scrape);
        }

        final binding = WidgetsBinding.instance;
        final rootElement = binding.renderViewElement;
        if (rootElement != null) {
          _scrape(rootElement);
        }
      } catch (e) {
        // Silent catch for extension calls
      }

      return developer.ServiceExtensionResponse.result(jsonEncode({'variables': widgetStates}));
    },
  );

  // Extension: Action Output Capture
  developer.registerExtension(
    'ext.teamsoft.ff.actionOutput',
    (String method, Map<String, dynamic> params) async {
      final name = params['name'] ?? 'unknown';
      final output = params['output'];
      final status = params['status'] ?? 'completed';
      try {
        developer.postEvent('teamsoft.action', {
          'action': name,
          'output': output?.toString() ?? '',
          'status': status,
          'ts': DateTime.now().millisecondsSinceEpoch,
        });
      } catch(_) {}
      return developer.ServiceExtensionResponse.result(
        jsonEncode({'status': 'logged', 'action': name})
      );
    },
  );

  // Extension: Global Properties
  developer.registerExtension(
    'ext.teamsoft.ff.getGlobalProps',
    (String method, Map<String, dynamic> params) async {
      try {
        final binding = WidgetsBinding.instance;
        final media = binding.platformDispatcher;
        if (media.views.isEmpty) return developer.ServiceExtensionResponse.result(jsonEncode({'error': 'no_views'}));
        final view = media.views.first;
        final size = view.physicalSize / view.devicePixelRatio;
        return developer.ServiceExtensionResponse.result(jsonEncode({
           'variables': {
              'screenWidth': size.width,
              'screenHeight': size.height,
              'pixelRatio': view.devicePixelRatio,
              'language': media.locale.languageCode,
              'isiOS': defaultTargetPlatform == TargetPlatform.iOS,
              'isAndroid': defaultTargetPlatform == TargetPlatform.android,
              'isWeb': kIsWeb,
           },
           'type': 'GlobalProps',
           'ts': DateTime.now().millisecondsSinceEpoch,
        }));
      } catch (e) {
        return developer.ServiceExtensionResponse.result(jsonEncode({'error': e.toString()}));
      }
    },
  );

  // Extension: Widget Tree (incremental, debounced — secondary priority)
  developer.registerExtension(
    'ext.teamsoft.ff.getWidgetTree',
    (String method, Map<String, dynamic> params) async {
      final now = DateTime.now().millisecondsSinceEpoch;
      if (now - _lastWidgetEmission < 500) {
        return developer.ServiceExtensionResponse.result(jsonEncode({'skipped': true}));
      }
      _lastWidgetEmission = now;
      try {
        final rootElement = WidgetsBinding.instance.renderViewElement;
        if (rootElement == null) return developer.ServiceExtensionResponse.result(jsonEncode({'tree': null}));
        final tree = _snapshotElementTS(rootElement, depth: 0, maxDepth: 6);
        
        return developer.ServiceExtensionResponse.result(jsonEncode({'tree': tree, 'ts': now}));
      } catch (e) {
        return developer.ServiceExtensionResponse.result(jsonEncode({'error': e.toString()}));
      }
    },
  );
}

Map<String, dynamic> _snapshotElementTS(Element? element, {int depth = 0, int maxDepth = 6}) {
  if (element == null || depth > maxDepth) return {};
  final children = <Map<String, dynamic>>[];
  Map<String, dynamic> pageVars = {};

  try {
    // Try to extract FlutterFlow Model variables if this is a StatefulElement
    if (element is StatefulElement) {
      final state = element.state;
      // Use dynamic to bypass strong typing, as we don't know the exact Model class
      try {
        final dynamic _stateDump = state;
        // Check if it has a typical FF _model field
        if (_stateDump.runtimeType.toString().contains('WidgetState')) {
             // In FF, the _model is usually initialized and bound. 
             // Without dart:mirrors on Flutter, we can't easily reflect arbitrary fields
             // but we will try extracting standard properties if we can cast it
             // Let's at least capture the state type to verify interception
             pageVars['_stateType'] = _stateDump.runtimeType.toString();
        }
      } catch (_) {}
    }

    element.visitChildren((child) {
      if (depth < maxDepth) children.add(_snapshotElementTS(child, depth: depth + 1, maxDepth: maxDepth));
    });
  } catch (_) {}
  
  return {
    'type': element?.widget.runtimeType.toString() ?? 'Unknown',
    'key': element?.widget.key?.toString(),
    'pageVariables': pageVars.isNotEmpty ? pageVars : null,
    'children': children,
  };
}

// TeamSoft Navigation Observer (lightweight, no UI)
class _TeamSoftNavObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    try {
      developer.postEvent('teamsoft.navigation', {
        'action': 'push',
        'route': route.settings.name ?? route.runtimeType.toString(),
        'previous': previousRoute?.settings.name ?? '',
        'ts': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (_) {}
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    try {
      developer.postEvent('teamsoft.navigation', {
        'action': 'pop',
        'route': route.settings.name ?? route.runtimeType.toString(),
        'ts': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (_) {}
    super.didPop(route, previousRoute);
  }
}

final _teamSoftNavObserver = _TeamSoftNavObserver();

