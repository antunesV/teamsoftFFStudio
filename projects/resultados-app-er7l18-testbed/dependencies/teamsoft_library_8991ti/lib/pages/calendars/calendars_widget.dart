import '/backend/schema/enums/enums.dart';
import '/components/calendario/calendar_day/calendar_day_widget.dart';
import '/components/calendario/calendar_item/calendar_item_widget.dart';
import '/components/calendario/calendar_month/calendar_month_widget.dart';
import '/components/calendario/calendar_week/calendar_week_widget.dart';
import '/components/filtros/filter_date_inline/filter_date_inline_widget.dart';
import '/components/menu/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/temp_card/temp_card_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'calendars_model.dart';
export 'calendars_model.dart';

class CalendarsWidget extends StatefulWidget {
  const CalendarsWidget({super.key});

  static String routeName = 'Calendars';
  static String routePath = '/calendars';
  static void maybeSetRouteName(String? updatedRouteName) =>
      routeName = updatedRouteName ?? routeName;
  static void maybeSetRoutePath(String? updatedRoutePath) =>
      routePath = updatedRoutePath ?? routePath;

  @override
  State<CalendarsWidget> createState() => _CalendarsWidgetState();
}

class _CalendarsWidgetState extends State<CalendarsWidget> {
  late CalendarsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalendarsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.weekDayJson = await actions.getWeekDaysJson(
        functions.dateDay(getCurrentTimestamp),
        functions.dateMonth(getCurrentTimestamp),
        functions.dateYear(getCurrentTimestamp),
        true,
        false,
      );
      _model.weekDaysCalendarWeek = getJsonField(
        _model.weekDayJson,
        r'''$.dias''',
      );
      _model.monthCalendarWeek = getJsonField(
        _model.weekDayJson,
        r'''$.mesFim''',
      );
      _model.yearCalendarWeek = getJsonField(
        _model.weekDayJson,
        r'''$.anoFim''',
      );
      _model.dayCalendarWeek = getJsonField(
        _model.weekDayJson,
        r'''$.dias[0].dia''',
      );
      safeSetState(() {});
      _model.addToJsonItems(<String, dynamic>{
        'teste': <String, dynamic>{
          'inicial_hour': getJsonField(
            <String, int?>{
              'value': 7,
            },
            r'''$.value''',
          ),
          'final_hour': getJsonField(
            <String, int?>{
              'value': 10,
            },
            r'''$.value''',
          ),
        },
      });
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).tsNeutral0,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).tsPrimaryDefault,
          automaticallyImplyLeading: false,
          title: Text(
            FFLocalizations.of(context).getText(
              '1mlrozop' /* Calendars */,
            ),
            style: FlutterFlowTheme.of(context).tsFontSemibold2xl.override(
                  font: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontStyle: FlutterFlowTheme.of(context)
                        .tsFontSemibold2xl
                        .fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).tsTextInverter,
                  fontSize: 24.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  fontStyle:
                      FlutterFlowTheme.of(context).tsFontSemibold2xl.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: wrapWithModel(
                      model: _model.menuModel,
                      updateCallback: () => safeSetState(() {}),
                      child: MenuWidget(
                        menus: functions.mockMenu(),
                        logoImage:
                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/teamsoft-library-8991ti/assets/jc1oe59h9a0y/teamsoft.jpg',
                        config: functions.configMenuMock(),
                        userData: functions.userDataMenuMock(),
                        menuOptions: FFAppState().menuOptions,
                        isSponsor: false,
                        variant: Variant.neutral,
                        isMobile: false,
                        currentRouteMenu: getCurrentRoute(context),
                        callbackAction: (action) async {},
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              _model.toggleCalendar = 1;
                              safeSetState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: _model.toggleCalendar == 1
                                    ? FlutterFlowTheme.of(context).tsPrimary500
                                    : FlutterFlowTheme.of(context).tsPrimary50,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    '6qbtwi2v' /* Calendar Month */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .tsPrimary900,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              _model.toggleCalendar = 2;
                              safeSetState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: _model.toggleCalendar == 2
                                    ? FlutterFlowTheme.of(context).tsPrimary500
                                    : FlutterFlowTheme.of(context).tsPrimary50,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    '2sdm4dms' /* Calendar Week */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .tsPrimary900,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              _model.toggleCalendar = 3;
                              safeSetState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: _model.toggleCalendar == 3
                                    ? FlutterFlowTheme.of(context).tsPrimary500
                                    : FlutterFlowTheme.of(context).tsPrimary50,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'd8l959ft' /* Calendar Day */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .tsPrimary900,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 8.0)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 200.0,
                            decoration: BoxDecoration(),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            if (_model.toggleCalendar == 1) {
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(),
                                child: wrapWithModel(
                                  model: _model.calendarMonthModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: CalendarMonthWidget(
                                    month: 8,
                                    year:
                                        functions.dateYear(getCurrentTimestamp),
                                    events: getJsonField(
                                      FFAppState().mockJson,
                                      r'''$.items[0].repositions''',
                                    ),
                                    callbackDate: (date, idReposition) async {
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text(idReposition!),
                                            content: Text(date.toString()),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext),
                                                child: Text('Ok'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    calendarItem: (String? title) =>
                                        CalendarItemWidget(
                                      title: title,
                                    ),
                                  ),
                                ),
                              );
                            } else if (_model.toggleCalendar == 2) {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 250.0,
                                    decoration: BoxDecoration(),
                                    child: wrapWithModel(
                                      model: _model.filterDateInlineModel,
                                      updateCallback: () => safeSetState(() {}),
                                      updateOnChange: true,
                                      child: FilterDateInlineWidget(
                                        month: _model.monthCalendarWeek,
                                        year: _model.yearCalendarWeek!,
                                        day: getJsonField(
                                          _model.weekDaysCalendarWeek,
                                          r'''$[0].dia''',
                                        ),
                                        type: TypeCalendarFilter.week,
                                        executeCallback:
                                            (month, year, day, weekDays) async {
                                          _model.weekDaysCalendarWeek =
                                              weekDays;
                                          _model.monthCalendarWeek = month;
                                          _model.yearCalendarWeek = year;
                                          safeSetState(() {});
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(),
                                    child: wrapWithModel(
                                      model: _model.calendarWeekModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: CalendarWeekWidget(
                                        weekDays: _model.weekDaysCalendarWeek,
                                        month: _model.monthCalendarWeek != null
                                            ? _model.monthCalendarWeek
                                            : functions
                                                .dateMonth(getCurrentTimestamp),
                                        year: _model.yearCalendarWeek != null
                                            ? _model.yearCalendarWeek
                                            : functions
                                                .dateYear(getCurrentTimestamp),
                                        items: FFAppState().tempScheduleSector,
                                        callBackCard:
                                            (formattedDay, hour) async {},
                                        callBackEdit: (selectedItem) async {},
                                        widget: (int? height,
                                                int? width,
                                                String idSchedule,
                                                dynamic item,
                                                int widhtPercentage) =>
                                            TempCardWidget(
                                          width: width,
                                          height: height,
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 8.0)),
                              );
                            } else {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: wrapWithModel(
                                      model: _model.calendarDayModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: CalendarDayWidget(
                                        hasHours: true,
                                        items: FFAppState().tempRoadmap,
                                        callback: () async {},
                                        widget:
                                            (double width, dynamic inforCard) =>
                                                TempCardWidget(
                                          width: 50,
                                          height: 100,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ].divide(SizedBox(height: 8.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
