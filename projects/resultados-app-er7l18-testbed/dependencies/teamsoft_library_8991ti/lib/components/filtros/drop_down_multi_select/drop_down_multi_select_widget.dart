import '/backend/schema/enums/enums.dart';
import '/components/inputs/input_checkbox/input_checkbox_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'drop_down_multi_select_model.dart';
export 'drop_down_multi_select_model.dart';

class DropDownMultiSelectWidget extends StatefulWidget {
  const DropDownMultiSelectWidget({
    super.key,
    required this.list,
    String? fieldId,
    String? fieldName,
    this.listSelected,
    this.width,
    bool? hasSearch,
    double? itemSpace,
    double? paddingTop,
    bool? addable,
    required this.variant,
    bool? isBottomSheet,
  })  : this.fieldId = fieldId ?? 'id',
        this.fieldName = fieldName ?? 'name',
        this.hasSearch = hasSearch ?? false,
        this.itemSpace = itemSpace ?? 0.0,
        this.paddingTop = paddingTop ?? 0.0,
        this.addable = addable ?? false,
        this.isBottomSheet = isBottomSheet ?? false;

  final List<dynamic>? list;
  final String fieldId;
  final String fieldName;
  final List<dynamic>? listSelected;
  final int? width;
  final bool hasSearch;
  final double itemSpace;
  final double paddingTop;
  final bool addable;
  final Variant? variant;
  final bool isBottomSheet;

  @override
  State<DropDownMultiSelectWidget> createState() =>
      _DropDownMultiSelectWidgetState();
}

class _DropDownMultiSelectWidgetState extends State<DropDownMultiSelectWidget>
    with TickerProviderStateMixin {
  late DropDownMultiSelectModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DropDownMultiSelectModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      for (int loop1Index = 0;
          loop1Index < _model.listSelectedDropDown.length;
          loop1Index++) {
        final currentLoop1Item = _model.listSelectedDropDown[loop1Index];
        if (getJsonField(
              currentLoop1Item,
              r'''$.addable''',
            ) ==
            getJsonField(
              <String, bool?>{
                'value': true,
              },
              r'''$.value''',
            )) {
          _model.removeFromListSelectedDropDown(currentLoop1Item);
          safeSetState(() {});
        }
      }
      _model.listSelectedDropDown =
          widget!.listSelected!.toList().cast<dynamic>();
      safeSetState(() {});
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    animationsMap.addAll({
      'iconOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          0.0,
          valueOrDefault<double>(
            widget!.paddingTop,
            0.0,
          ),
          0.0,
          0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: widget!.isBottomSheet
                ? null
                : (widget!.width != null ? widget!.width?.toDouble() : 400.0),
            constraints: BoxConstraints(
              maxHeight: 400.0,
            ),
            decoration: BoxDecoration(
              color: () {
                if (widget!.variant == Variant.neutral) {
                  return FlutterFlowTheme.of(context).tsNeutral0;
                } else if (widget!.variant == Variant.primary) {
                  return FlutterFlowTheme.of(context).tsPrimaryDefault;
                } else if (widget!.variant == Variant.dark) {
                  return Color(0xFF1F1F1F);
                } else {
                  return FlutterFlowTheme.of(context).tsNeutral0;
                }
              }(),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(valueOrDefault<double>(
                  widget!.isBottomSheet ? 0.0 : 8.0,
                  0.0,
                )),
                bottomRight: Radius.circular(valueOrDefault<double>(
                  widget!.isBottomSheet ? 0.0 : 8.0,
                  0.0,
                )),
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              border: Border.all(
                color: () {
                  if (widget!.variant == Variant.neutral) {
                    return FlutterFlowTheme.of(context).tsNeutral200;
                  } else if (widget!.variant == Variant.primary) {
                    return FlutterFlowTheme.of(context).tsPrimary200;
                  } else if (widget!.variant == Variant.dark) {
                    return FlutterFlowTheme.of(context).tsNeutral800;
                  } else {
                    return FlutterFlowTheme.of(context).tsNeutral200;
                  }
                }(),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget!.hasSearch)
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(),
                      child: TextFormField(
                        controller: _model.textController,
                        focusNode: _model.textFieldFocusNode,
                        onChanged: (_) => EasyDebounce.debounce(
                          '_model.textController',
                          Duration(milliseconds: 100),
                          () async {
                            if (widget!.list!
                                .where((e) => functions.filterSingleSelecte(
                                    e,
                                    widget!.fieldName,
                                    _model.textController.text))
                                .toList()
                                .isNotEmpty) {
                              _model.add = false;
                              safeSetState(() {});
                            } else {
                              _model.add = true;
                              safeSetState(() {});
                            }

                            safeSetState(() {});
                          },
                        ),
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          isDense: true,
                          labelStyle: FlutterFlowTheme.of(context)
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
                                color: widget!.variant == Variant.dark
                                    ? FlutterFlowTheme.of(context)
                                        .tsTextInverter
                                    : FlutterFlowTheme.of(context)
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
                            'pjyu088c' /* Digite para buscar */,
                          ),
                          hintStyle: FlutterFlowTheme.of(context)
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
                                color: widget!.variant == Variant.dark
                                    ? FlutterFlowTheme.of(context).tsNeutral500
                                    : FlutterFlowTheme.of(context).tsNeutral700,
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
                              color: widget!.variant == Variant.dark
                                  ? Color(0xFF333333)
                                  : FlutterFlowTheme.of(context).tsNeutral300,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).tsNeutral700,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).tsDanger300,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).tsDanger300,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor: widget!.variant == Variant.dark
                              ? FlutterFlowTheme.of(context).tsNeutral900
                              : FlutterFlowTheme.of(context).tsNeutral0,
                          prefixIcon: Icon(
                            FFIcons.kmagnifyingGlass,
                            color:
                                FlutterFlowTheme.of(context).tsPrimaryDefault,
                            size: 16.0,
                          ),
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
                              color: widget!.variant == Variant.dark
                                  ? FlutterFlowTheme.of(context).tsTextInverter
                                  : FlutterFlowTheme.of(context).tsTextDefault,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .tsFontNormalSm
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .tsFontNormalSm
                                  .fontStyle,
                            ),
                        cursorColor: widget!.variant == Variant.dark
                            ? FlutterFlowTheme.of(context).tsTextInverter
                            : FlutterFlowTheme.of(context).tsTextDefault,
                        validator:
                            _model.textControllerValidator.asValidator(context),
                      ),
                    ),
                  ),
                if (widget!.hasSearch)
                  Divider(
                    thickness: 1.0,
                    color: widget!.variant == Variant.dark
                        ? Color(0xFF1F1F1F)
                        : FlutterFlowTheme.of(context).tsNeutral300,
                  ),
                Container(
                  height: 170.0,
                  decoration: BoxDecoration(),
                  child: Builder(
                    builder: (context) {
                      if (widget!.addable && (widget!.list!.length > 0)) {
                        return Builder(
                          builder: (context) {
                            if (!_model.add) {
                              return Builder(
                                builder: (context) {
                                  final dinamicListCheckBox = widget!.list!
                                      .where((e) =>
                                          functions.filterSingleSelecte(
                                              e,
                                              widget!.fieldName,
                                              _model.textController.text))
                                      .toList();

                                  return ListView.separated(
                                    padding: EdgeInsets.zero,
                                    primary: false,
                                    scrollDirection: Axis.vertical,
                                    itemCount: dinamicListCheckBox.length,
                                    separatorBuilder: (_, __) =>
                                        SizedBox(height: widget!.itemSpace),
                                    itemBuilder:
                                        (context, dinamicListCheckBoxIndex) {
                                      final dinamicListCheckBoxItem =
                                          dinamicListCheckBox[
                                              dinamicListCheckBoxIndex];
                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          if (dinamicListCheckBoxIndex == 0)
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                if (_model.listSelectedDropDown
                                                        .length ==
                                                    0) {
                                                  _model.listSelectedDropDown =
                                                      widget!.list!
                                                          .toList()
                                                          .cast<dynamic>();
                                                  safeSetState(() {});
                                                } else {
                                                  _model.listSelectedDropDown =
                                                      [];
                                                  safeSetState(() {});
                                                }
                                              },
                                              child: Container(
                                                height: 40.0,
                                                decoration: BoxDecoration(),
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(4.0, 0.0,
                                                                8.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Container(
                                                            child:
                                                                InputCheckboxWidget(
                                                              key: Key(
                                                                  'Key0n7_${dinamicListCheckBoxIndex}_of_${dinamicListCheckBox.length}'),
                                                              toggle: () {
                                                                if (widget!.list
                                                                        ?.length ==
                                                                    _model
                                                                        .listSelectedDropDown
                                                                        .length) {
                                                                  return 1;
                                                                } else if (_model
                                                                        .listSelectedDropDown
                                                                        .length ==
                                                                    0) {
                                                                  return 0;
                                                                } else {
                                                                  return 2;
                                                                }
                                                              }(),
                                                              variant: widget!
                                                                  .variant,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'et7tykcc' /* (Selecionar Todos) */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .tsFontNormalSm
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .roboto(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tsFontNormalSm
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tsFontNormalSm
                                                                      .fontStyle,
                                                                ),
                                                                color: widget!
                                                                            .variant ==
                                                                        Variant
                                                                            .dark
                                                                    ? FlutterFlowTheme.of(
                                                                            context)
                                                                        .tsTextInverter
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .tsTextDefault,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tsFontNormalSm
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tsFontNormalSm
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ],
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
                                              if (_model.listSelectedDropDown
                                                  .where((e) =>
                                                      functions
                                                          .getDataFromField(
                                                              getJsonField(
                                                                e,
                                                                r'''$''',
                                                              ),
                                                              widget!
                                                                  .fieldId) ==
                                                      functions
                                                          .getDataFromField(
                                                              getJsonField(
                                                                dinamicListCheckBoxItem,
                                                                r'''$''',
                                                              ),
                                                              widget!.fieldId))
                                                  .toList()
                                                  .isNotEmpty) {
                                                _model.listSelectedDropDown = _model
                                                    .listSelectedDropDown
                                                    .where((e) =>
                                                        functions
                                                            .getDataFromField(
                                                                getJsonField(
                                                                  e,
                                                                  r'''$''',
                                                                ),
                                                                widget!
                                                                    .fieldId) !=
                                                        functions
                                                            .getDataFromField(
                                                                getJsonField(
                                                                  dinamicListCheckBoxItem,
                                                                  r'''$''',
                                                                ),
                                                                widget!
                                                                    .fieldId))
                                                    .toList()
                                                    .cast<dynamic>();
                                                safeSetState(() {});
                                              } else {
                                                _model
                                                    .addToListSelectedDropDown(
                                                        getJsonField(
                                                  dinamicListCheckBoxItem,
                                                  r'''$''',
                                                ));
                                                safeSetState(() {});
                                              }
                                            },
                                            child: Container(
                                              height: 40.0,
                                              decoration: BoxDecoration(),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          4.0, 0.0, 4.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Container(
                                                          child: wrapWithModel(
                                                            model: _model
                                                                .inputCheckboxModels2
                                                                .getModel(
                                                              dinamicListCheckBoxIndex
                                                                  .toString(),
                                                              dinamicListCheckBoxIndex,
                                                            ),
                                                            updateCallback: () =>
                                                                safeSetState(
                                                                    () {}),
                                                            updateOnChange:
                                                                true,
                                                            child:
                                                                InputCheckboxWidget(
                                                              key: Key(
                                                                'Key0s8_${dinamicListCheckBoxIndex.toString()}',
                                                              ),
                                                              toggle: _model
                                                                      .listSelectedDropDown
                                                                      .where((e) =>
                                                                          functions.getDataFromField(
                                                                              getJsonField(
                                                                                e,
                                                                                r'''$''',
                                                                              ),
                                                                              widget!.fieldId) ==
                                                                          functions.getDataFromField(
                                                                              getJsonField(
                                                                                dinamicListCheckBoxItem,
                                                                                r'''$''',
                                                                              ),
                                                                              widget!.fieldId))
                                                                      .toList()
                                                                      .isNotEmpty
                                                                  ? 1
                                                                  : 0,
                                                              variant: widget!
                                                                  .variant,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        functions.getDataFromField(
                                                            dinamicListCheckBoxItem,
                                                            widget!.fieldName),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tsFontNormalSm
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tsFontNormalSm
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tsFontNormalSm
                                                                        .fontStyle,
                                                                  ),
                                                                  color: widget!
                                                                              .variant ==
                                                                          Variant
                                                                              .dark
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .tsTextInverter
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .tsTextDefault,
                                                                  fontSize:
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tsFontNormalSm
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tsFontNormalSm
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ].divide(SizedBox(
                                            height: widget!.itemSpace)),
                                      );
                                    },
                                  );
                                },
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            _model.textController.text,
                                            style: FlutterFlowTheme.of(context)
                                                .tsFontNormalSm
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .tsFontNormalSm
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .tsFontNormalSm
                                                            .fontStyle,
                                                  ),
                                                  color: widget!.variant ==
                                                          Variant.dark
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .tsTextInverter
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .tsTextDefault,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .tsFontNormalSm
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .tsFontNormalSm
                                                          .fontStyle,
                                                ),
                                          ),
                                          FFButtonWidget(
                                            onPressed: () async {
                                              _model.addToListSelectedDropDown(
                                                  getJsonField(
                                                <String, dynamic>{
                                                  'name': _model
                                                      .textController.text,
                                                  'addable': widget!.addable,
                                                },
                                                r'''$''',
                                              ));
                                              safeSetState(() {});
                                              Navigator.pop(context,
                                                  _model.listSelectedDropDown);
                                            },
                                            text: FFLocalizations.of(context)
                                                .getText(
                                              'r1k8q8ot' /* adicionar */,
                                            ),
                                            icon: Icon(
                                              FFIcons.kplus,
                                              size: 15.0,
                                            ),
                                            options: FFButtonOptions(
                                              height: 40.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              iconColor:
                                                  FlutterFlowTheme.of(context)
                                                      .tsPrimaryDefault,
                                              color: widget!.variant ==
                                                      Variant.dark
                                                  ? FlutterFlowTheme.of(context)
                                                      .tsNeutral900
                                                  : FlutterFlowTheme.of(context)
                                                      .tsNeutral0,
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    font:
                                                        GoogleFonts.interTight(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .tsPrimaryDefault,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontStyle,
                                                  ),
                                              elevation: 0.0,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        );
                      } else if (widget!.list!.length > 0) {
                        return Builder(
                          builder: (context) {
                            final dinamicListCheckBox = widget!.list!
                                .where((e) => functions.filterSingleSelecte(
                                    e,
                                    widget!.fieldName,
                                    _model.textController.text))
                                .toList();

                            return ListView.separated(
                              padding: EdgeInsets.zero,
                              primary: false,
                              scrollDirection: Axis.vertical,
                              itemCount: dinamicListCheckBox.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: widget!.itemSpace),
                              itemBuilder: (context, dinamicListCheckBoxIndex) {
                                final dinamicListCheckBoxItem =
                                    dinamicListCheckBox[
                                        dinamicListCheckBoxIndex];
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    if (dinamicListCheckBoxIndex == 0)
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          if (_model.listSelectedDropDown
                                                  .length ==
                                              0) {
                                            _model.listSelectedDropDown =
                                                widget!.list!
                                                    .toList()
                                                    .cast<dynamic>();
                                            safeSetState(() {});
                                          } else {
                                            _model.listSelectedDropDown = [];
                                            safeSetState(() {});
                                          }
                                        },
                                        child: Container(
                                          height: 40.0,
                                          decoration: BoxDecoration(),
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(4.0, 0.0, 8.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Container(
                                                      child:
                                                          InputCheckboxWidget(
                                                        key: Key(
                                                            'Keyl9p_${dinamicListCheckBoxIndex}_of_${dinamicListCheckBox.length}'),
                                                        toggle: () {
                                                          if (widget!.list
                                                                  ?.length ==
                                                              _model
                                                                  .listSelectedDropDown
                                                                  .length) {
                                                            return 1;
                                                          } else if (_model
                                                                  .listSelectedDropDown
                                                                  .length ==
                                                              0) {
                                                            return 0;
                                                          } else {
                                                            return 2;
                                                          }
                                                        }(),
                                                        variant:
                                                            widget!.variant,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      '05jp9wpw' /* (Selecionar Todos) */,
                                                    ),
                                                    style:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .tsFontNormalSm
                                                            .override(
                                                              font: GoogleFonts
                                                                  .roboto(
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tsFontNormalSm
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tsFontNormalSm
                                                                    .fontStyle,
                                                              ),
                                                              color: () {
                                                                if (widget!
                                                                        .variant ==
                                                                    Variant
                                                                        .neutral) {
                                                                  return FlutterFlowTheme.of(
                                                                          context)
                                                                      .tsTextDefault;
                                                                } else if (widget!
                                                                        .variant ==
                                                                    Variant
                                                                        .primary) {
                                                                  return FlutterFlowTheme.of(
                                                                          context)
                                                                      .tsTextDefault;
                                                                } else if (widget!
                                                                        .variant ==
                                                                    Variant
                                                                        .dark) {
                                                                  return FlutterFlowTheme.of(
                                                                          context)
                                                                      .tsNeutral0;
                                                                } else {
                                                                  return FlutterFlowTheme.of(
                                                                          context)
                                                                      .tsTextDefault;
                                                                }
                                                              }(),
                                                              fontSize: 14.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight: FlutterFlowTheme
                                                                      .of(context)
                                                                  .tsFontNormalSm
                                                                  .fontWeight,
                                                              fontStyle: FlutterFlowTheme
                                                                      .of(context)
                                                                  .tsFontNormalSm
                                                                  .fontStyle,
                                                            ),
                                                  ),
                                                ],
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
                                        if (_model.listSelectedDropDown
                                            .where((e) =>
                                                functions.getDataFromField(
                                                    getJsonField(
                                                      e,
                                                      r'''$''',
                                                    ),
                                                    widget!.fieldId) ==
                                                functions.getDataFromField(
                                                    getJsonField(
                                                      dinamicListCheckBoxItem,
                                                      r'''$''',
                                                    ),
                                                    widget!.fieldId))
                                            .toList()
                                            .isNotEmpty) {
                                          _model.listSelectedDropDown = _model
                                              .listSelectedDropDown
                                              .where((e) =>
                                                  functions.getDataFromField(
                                                      getJsonField(
                                                        e,
                                                        r'''$''',
                                                      ),
                                                      widget!.fieldId) !=
                                                  functions.getDataFromField(
                                                      getJsonField(
                                                        dinamicListCheckBoxItem,
                                                        r'''$''',
                                                      ),
                                                      widget!.fieldId))
                                              .toList()
                                              .cast<dynamic>();
                                          safeSetState(() {});
                                        } else {
                                          _model.addToListSelectedDropDown(
                                              getJsonField(
                                            dinamicListCheckBoxItem,
                                            r'''$''',
                                          ));
                                          safeSetState(() {});
                                        }
                                      },
                                      child: Container(
                                        height: 40.0,
                                        decoration: BoxDecoration(),
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    4.0, 0.0, 4.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Container(
                                                    child: wrapWithModel(
                                                      model: _model
                                                          .inputCheckboxModels4
                                                          .getModel(
                                                        dinamicListCheckBoxIndex
                                                            .toString(),
                                                        dinamicListCheckBoxIndex,
                                                      ),
                                                      updateCallback: () =>
                                                          safeSetState(() {}),
                                                      updateOnChange: true,
                                                      child:
                                                          InputCheckboxWidget(
                                                        key: Key(
                                                          'Keyhgo_${dinamicListCheckBoxIndex.toString()}',
                                                        ),
                                                        toggle: _model
                                                                .listSelectedDropDown
                                                                .where((e) =>
                                                                    functions.getDataFromField(
                                                                        getJsonField(
                                                                          e,
                                                                          r'''$''',
                                                                        ),
                                                                        widget!.fieldId) ==
                                                                    functions.getDataFromField(
                                                                        getJsonField(
                                                                          dinamicListCheckBoxItem,
                                                                          r'''$''',
                                                                        ),
                                                                        widget!.fieldId))
                                                                .toList()
                                                                .isNotEmpty
                                                            ? 1
                                                            : 0,
                                                        variant:
                                                            widget!.variant,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  functions.getDataFromField(
                                                      dinamicListCheckBoxItem,
                                                      widget!.fieldName),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .tsFontNormalSm
                                                      .override(
                                                        font:
                                                            GoogleFonts.roboto(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .tsFontNormalSm
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .tsFontNormalSm
                                                                  .fontStyle,
                                                        ),
                                                        color: () {
                                                          if (widget!.variant ==
                                                              Variant.neutral) {
                                                            return FlutterFlowTheme
                                                                    .of(context)
                                                                .tsTextDefault;
                                                          } else if (widget!
                                                                  .variant ==
                                                              Variant.primary) {
                                                            return FlutterFlowTheme
                                                                    .of(context)
                                                                .tsTextDefault;
                                                          } else if (widget!
                                                                  .variant ==
                                                              Variant.dark) {
                                                            return FlutterFlowTheme
                                                                    .of(context)
                                                                .tsNeutral0;
                                                          } else {
                                                            return FlutterFlowTheme
                                                                    .of(context)
                                                                .tsTextDefault;
                                                          }
                                                        }(),
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tsFontNormalSm
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tsFontNormalSm
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: widget!.itemSpace)),
                                );
                              },
                            );
                          },
                        );
                      } else {
                        return Icon(
                          FFIcons.karrowsClockwise,
                          color: FlutterFlowTheme.of(context).tsPrimaryDefault,
                          size: 84.0,
                        ).animateOnPageLoad(
                            animationsMap['iconOnPageLoadAnimation']!);
                      }
                    },
                  ),
                ),
                Divider(
                  thickness: 1.0,
                  color: widget!.variant == Variant.dark
                      ? Color(0xFF1F1F1F)
                      : FlutterFlowTheme.of(context).tsNeutral300,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        text: FFLocalizations.of(context).getText(
                          'i40knzhb' /* Limpar */,
                        ),
                        options: FFButtonOptions(
                          height: 36.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 8.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Colors.transparent,
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
                                    .tsPrimaryDefault,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .tsFontSemiboldBase
                                    .fontStyle,
                              ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).tsPrimaryDefault,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        showLoadingIndicator: false,
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          if (widget!.isBottomSheet) {
                            Navigator.pop(context, _model.listSelectedDropDown);
                          } else {
                            Navigator.pop(context, _model.listSelectedDropDown);
                          }
                        },
                        text: FFLocalizations.of(context).getText(
                          'nx08m9k7' /* Aplicar */,
                        ),
                        options: FFButtonOptions(
                          height: 36.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 8.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).tsPrimaryDefault,
                          textStyle: FlutterFlowTheme.of(context)
                              .tsFontSemiboldBase
                              .override(
                                font: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .tsFontSemiboldBase
                                      .fontStyle,
                                ),
                                color: widget!.variant == Variant.dark
                                    ? FlutterFlowTheme.of(context).tsTextDefault
                                    : FlutterFlowTheme.of(context)
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
