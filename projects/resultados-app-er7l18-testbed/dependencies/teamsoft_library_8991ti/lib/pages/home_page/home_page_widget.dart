import '/backend/schema/enums/enums.dart';
import '/components/calendario/calendar_item/calendar_item_widget.dart';
import '/components/calendario/calendar_month/calendar_month_widget.dart';
import '/components/filtros/filter_date/filter_date_widget.dart';
import '/components/filtros/filter_date_inline/filter_date_inline_widget.dart';
import '/components/filtros/filter_value/filter_value_widget.dart';
import '/components/inputs/input_field_single_select/input_field_single_select_widget.dart';
import '/components/inputs/input_multi_select/input_multi_select_widget.dart';
import '/components/inputs/input_number/input_number_widget.dart';
import '/components/inputs/input_single_select/input_single_select_widget.dart';
import '/components/menu/horizontal/menu_horizontal/menu_horizontal_widget.dart';
import '/components/menu/menu/menu_widget.dart';
import '/components/toast/toast/toast_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  static String routeName = 'HomePage';
  static String routePath = '/home';
  static void maybeSetRouteName(String? updatedRouteName) =>
      routeName = updatedRouteName ?? routeName;
  static void maybeSetRoutePath(String? updatedRoutePath) =>
      routePath = updatedRoutePath ?? routePath;

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

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
              '1uahdjhb' /* Home */,
            ),
            style: FlutterFlowTheme.of(context).tsFontNormal2xl.override(
                  font: GoogleFonts.roboto(
                    fontWeight:
                        FlutterFlowTheme.of(context).tsFontNormal2xl.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).tsFontNormal2xl.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).tsTextInverter,
                  fontSize: 24.0,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).tsFontNormal2xl.fontWeight,
                  fontStyle:
                      FlutterFlowTheme.of(context).tsFontNormal2xl.fontStyle,
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
                    child: Container(
                      width: 210.0,
                      decoration: BoxDecoration(),
                      alignment: AlignmentDirectional(-1.0, 0.0),
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
                          variant: Variant.primary,
                          menuWidthExpanded: 210,
                          meuWidthCollapsed: 58,
                          isMobile: false,
                          currentRouteMenu: getCurrentRoute(context),
                          callbackAction: (action) async {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text(action),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
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
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 1.0),
                              child: wrapWithModel(
                                model: _model.filterDateModel,
                                updateCallback: () => safeSetState(() {}),
                                updateOnChange: true,
                                child: FilterDateWidget(
                                  label: 'Período',
                                  type: TypeCalendar.interval,
                                  hasLeftIcon: true,
                                  variant: Variant.dark,
                                  executeAction:
                                      (initialDate, finalDate) async {},
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 130.0,
                            decoration: BoxDecoration(),
                            child: wrapWithModel(
                              model: _model.inputMultiSelectModel,
                              updateCallback: () => safeSetState(() {}),
                              updateOnChange: true,
                              child: InputMultiSelectWidget(
                                label: 'Status',
                                icon: Icon(
                                  FFIcons.kcircleDashed,
                                  color:
                                      FlutterFlowTheme.of(context).tsNeutral800,
                                  size: 16.0,
                                ),
                                list: functions.randomJsonList(),
                                fieldId: 'id',
                                fieldName: 'name',
                                variant: Variant.dark,
                                hasSearch: true,
                                addable: true,
                                executeAction: (dataMultiSelect) async {
                                  if (dataMultiSelect != null &&
                                      (dataMultiSelect)!.isNotEmpty) {
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: Text(dataMultiSelect!
                                              .firstOrNull!
                                              .toString()),
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
                                  }
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: 270.0,
                            decoration: BoxDecoration(),
                            child: wrapWithModel(
                              model: _model.filterDateInlineModel,
                              updateCallback: () => safeSetState(() {}),
                              child: FilterDateInlineWidget(
                                month: functions.dateMonth(getCurrentTimestamp),
                                year: functions.dateYear(getCurrentTimestamp),
                                day: functions.dateDay(getCurrentTimestamp),
                                type: TypeCalendarFilter.week,
                                isToday: false,
                                executeCallback:
                                    (month, year, day, weekDays) async {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title: Text(
                                            '${day?.toString()} - ${((day!) + 6).toString()}'),
                                        content: Text(month!.toString()),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text(year!.toString()),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: wrapWithModel(
                              model: _model.filterValueModel,
                              updateCallback: () => safeSetState(() {}),
                              child: FilterValueWidget(
                                label: 'Salário',
                                hasLeftIcon: false,
                                type: TypeCalendar.interval,
                                variant: Variant.neutral,
                                executeAction:
                                    (initialValue, finalValue) async {},
                              ),
                            ),
                          ),
                          Builder(
                            builder: (context) => FFButtonWidget(
                              onPressed: () async {
                                await showDialog(
                                  barrierColor: Colors.transparent,
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (dialogContext) {
                                    return Dialog(
                                      elevation: 0,
                                      insetPadding: EdgeInsets.zero,
                                      backgroundColor: Colors.transparent,
                                      alignment: AlignmentDirectional(
                                              0.95, -0.9)
                                          .resolve(Directionality.of(context)),
                                      child: GestureDetector(
                                        onTap: () {
                                          FocusScope.of(dialogContext)
                                              .unfocus();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        },
                                        child: ToastWidget(
                                          colorGradient:
                                              FlutterFlowTheme.of(context)
                                                  .tsPrimaryDefault,
                                          iconToast: Icon(
                                            FFIcons.kcheckCircleFill,
                                            color: FlutterFlowTheme.of(context)
                                                .tsSuccess300,
                                            size: 24.0,
                                          ),
                                          label: 'Success',
                                          iconClose: Icon(
                                            FFIcons.kxBold,
                                            color: FlutterFlowTheme.of(context)
                                                .tsNeutral800,
                                            size: 16.0,
                                          ),
                                          message: 'Sim',
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              text: FFLocalizations.of(context).getText(
                                'ictjqye6' /* Toast */,
                              ),
                              options: FFButtonOptions(
                                height: 40.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 0.0, 8.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context)
                                    .tsPrimaryDefault,
                                textStyle: FlutterFlowTheme.of(context)
                                    .tsFontSemiboldBase
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .tsFontSemiboldBase
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .tsTextInverter,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .tsFontSemiboldBase
                                          .fontStyle,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              showLoadingIndicator: false,
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
                            child: wrapWithModel(
                              model: _model.inputSingleSelectModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: InputSingleSelectWidget(
                                label: 'Single BottomSheet',
                                fieldId: 'id',
                                fieldName: 'description',
                                list: functions.randomJsonList(),
                                variant: Variant.neutral,
                                styleOnSelected: false,
                                hasError: false,
                                hasSearch: true,
                                unlink: true,
                                addable: true,
                                isBottomSheet: true,
                                noBorder: false,
                                hasTitle: false,
                                unselectable: true,
                                executeAction: (dataSingleSelect) async {
                                  _model.teste = dataSingleSelect;
                                  safeSetState(() {});
                                  if (getJsonField(
                                    dataSingleSelect,
                                    r'''$.addable''',
                                  )) {
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: Text('true'),
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
                                  }
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: 200.0,
                            decoration: BoxDecoration(),
                            child: wrapWithModel(
                              model: _model.inputSingleSelectModel2,
                              updateCallback: () => safeSetState(() {}),
                              child: InputSingleSelectWidget(
                                label: 'Single DropDown',
                                fieldId: 'id',
                                fieldName: 'description',
                                styleOnSelected: false,
                                hasError: false,
                                hasSearch: false,
                                unlink: true,
                                addable: false,
                                isBottomSheet: false,
                                noBorder: false,
                                list: functions.randomJsonList(),
                                variant: Variant.primary,
                                maxCharacters: 50,
                                executeAction: (dataSingleSelect) async {},
                              ),
                            ),
                          ),
                          Container(
                            width: 150.0,
                            decoration: BoxDecoration(),
                            child: wrapWithModel(
                              model: _model.inputNumberModel,
                              updateCallback: () => safeSetState(() {}),
                              child: InputNumberWidget(),
                            ),
                          ),
                          Container(
                            width: 24.0,
                            height: 24.0,
                            child: custom_widgets.CustomIcon(
                              width: 24.0,
                              height: 24.0,
                              iconName: 'userFill',
                              color: FlutterFlowTheme.of(context).tsTextDefault,
                              iconLibrary: '',
                            ),
                          ),
                          Builder(
                            builder: (context) => FFButtonWidget(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (dialogContext) {
                                    return Dialog(
                                      elevation: 0,
                                      insetPadding: EdgeInsets.zero,
                                      backgroundColor: Colors.transparent,
                                      alignment: AlignmentDirectional(-1.0, 0.0)
                                          .resolve(Directionality.of(context)),
                                      child: GestureDetector(
                                        onTap: () {
                                          FocusScope.of(dialogContext)
                                              .unfocus();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        },
                                        child: MenuWidget(
                                          menus: functions.mockMenu(),
                                          logoImage:
                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/teamsoft-library-8991ti/assets/jc1oe59h9a0y/teamsoft.jpg',
                                          config: functions.configMenuMock(),
                                          userData:
                                              functions.userDataMenuMock(),
                                          isMobile: true,
                                          version: 'v1',
                                          menuOptions: FFAppState().menuOptions,
                                          isSponsor: false,
                                          variant: Variant.primary,
                                          imageHeight: 0,
                                          menuWidthExpanded: 450,
                                          currentRouteMenu: '',
                                          callbackAction: (action) async {
                                            await showDialog(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text('AAAA'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext),
                                                      child: Text('Ok'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              text: FFLocalizations.of(context).getText(
                                'ivhd1xuk' /* menu */,
                              ),
                              options: FFButtonOptions(
                                height: 40.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context)
                                    .tsPrimaryDefault,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 16.0)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 200.0,
                            decoration: BoxDecoration(),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              context.pushNamed(CalendarsWidget.routeName);
                            },
                            text: FFLocalizations.of(context).getText(
                              'gu8fones' /* Calendars */,
                            ),
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 8.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color:
                                  FlutterFlowTheme.of(context).tsPrimaryDefault,
                              textStyle: FlutterFlowTheme.of(context)
                                  .tsFontSemiboldBase
                                  .override(
                                    font: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .tsFontSemiboldBase
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .tsTextInverter,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .tsFontSemiboldBase
                                        .fontStyle,
                                  ),
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            showLoadingIndicator: false,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).tsNeutral0,
                            ),
                            child: Container(
                              width: 200.0,
                              child: TextFormField(
                                controller: _model.textController,
                                focusNode: _model.textFieldFocusNode,
                                autofocus: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .tsFontNormalSm
                                      .override(
                                        font: GoogleFonts.roboto(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .tsFontNormalSm
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .tsFontNormalSm
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .tsTextDefault,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .tsFontNormalSm
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .tsFontNormalSm
                                            .fontStyle,
                                      ),
                                  hintText: FFLocalizations.of(context).getText(
                                    '0iobwfiy' /* inputCpf/Cnpj */,
                                  ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .tsFontNormalSm
                                      .override(
                                        font: GoogleFonts.roboto(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .tsFontNormalSm
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .tsFontNormalSm
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .tsNeutral700,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .tsFontNormalSm
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .tsFontNormalSm
                                            .fontStyle,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .tsNeutral300,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .tsNeutral700,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .tsDanger300,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .tsDanger300,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor:
                                      FlutterFlowTheme.of(context).tsNeutral0,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .tsFontNormalSm
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .tsFontNormalSm
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .tsFontNormalSm
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .tsTextDefault,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .tsFontNormalSm
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .tsFontNormalSm
                                          .fontStyle,
                                    ),
                                cursorColor:
                                    FlutterFlowTheme.of(context).tsTextDefault,
                                validator: _model.textControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              _model.outputcpf = await actions.validateCpfCnpj(
                                _model.textController.text,
                                ValidationCpfCnpj.cpf,
                              );
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text(_model.textController.text),
                                    content: Text(_model.outputcpf!.toString()),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );

                              safeSetState(() {});
                            },
                            text: FFLocalizations.of(context).getText(
                              'wp3bzzjq' /* cpf */,
                            ),
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 8.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color:
                                  FlutterFlowTheme.of(context).tsPrimaryDefault,
                              textStyle: FlutterFlowTheme.of(context)
                                  .tsFontSemiboldBase
                                  .override(
                                    font: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .tsFontSemiboldBase
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .tsTextInverter,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .tsFontSemiboldBase
                                        .fontStyle,
                                  ),
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            showLoadingIndicator: false,
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              _model.outputcnpj = await actions.validateCpfCnpj(
                                _model.textController.text,
                                ValidationCpfCnpj.cnpj,
                              );
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text(_model.textController.text),
                                    content:
                                        Text(_model.outputcnpj!.toString()),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );

                              safeSetState(() {});
                            },
                            text: FFLocalizations.of(context).getText(
                              'sdivuz53' /* cnpj */,
                            ),
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 8.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color:
                                  FlutterFlowTheme.of(context).tsPrimaryDefault,
                              textStyle: FlutterFlowTheme.of(context)
                                  .tsFontSemiboldBase
                                  .override(
                                    font: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .tsFontSemiboldBase
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .tsTextInverter,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .tsFontSemiboldBase
                                        .fontStyle,
                                  ),
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            showLoadingIndicator: false,
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              _model.outputambos =
                                  await actions.validateCpfCnpj(
                                _model.textController.text,
                                ValidationCpfCnpj.ambos,
                              );
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text(_model.textController.text),
                                    content:
                                        Text(_model.outputambos!.toString()),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );

                              safeSetState(() {});
                            },
                            text: FFLocalizations.of(context).getText(
                              '4pjqd3tb' /* ambos */,
                            ),
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 8.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color:
                                  FlutterFlowTheme.of(context).tsPrimaryDefault,
                              textStyle: FlutterFlowTheme.of(context)
                                  .tsFontSemiboldBase
                                  .override(
                                    font: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .tsFontSemiboldBase
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .tsTextInverter,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .tsFontSemiboldBase
                                        .fontStyle,
                                  ),
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            showLoadingIndicator: false,
                          ),
                          Expanded(
                            child: wrapWithModel(
                              model: _model.inputFieldSingleSelectModel,
                              updateCallback: () => safeSetState(() {}),
                              child: InputFieldSingleSelectWidget(),
                            ),
                          ),
                        ].divide(SizedBox(width: 8.0)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 300.0,
                            decoration: BoxDecoration(),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(),
                          child: wrapWithModel(
                            model: _model.calendarMonthModel,
                            updateCallback: () => safeSetState(() {}),
                            child: CalendarMonthWidget(
                              month: 8,
                              year: functions.dateYear(getCurrentTimestamp),
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
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
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
                        ),
                      ),
                      Container(
                        height: 70.0,
                        decoration: BoxDecoration(),
                        child: wrapWithModel(
                          model: _model.menuHorizontalModel,
                          updateCallback: () => safeSetState(() {}),
                          child: MenuHorizontalWidget(
                            image: random_data.randomImageUrl(
                              0,
                              0,
                            ),
                            menu: FFAppState().menuHorizontal,
                            userData: functions.userDataMenuMock(),
                            gearOptions: FFAppState().gearOptions,
                          ),
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
