import '/backend/schema/enums/enums.dart';
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
import 'drop_down_single_select_model.dart';
export 'drop_down_single_select_model.dart';

class DropDownSingleSelectWidget extends StatefulWidget {
  const DropDownSingleSelectWidget({
    super.key,
    required this.list,
    String? fieldId,
    String? fieldName,
    this.listSelected,
    bool? hasSearch,
    bool? unlink,
    this.fieldDescription,
    this.fieldImage,
    this.width,
    this.insideHeight,
    double? itemSpace,
    double? paddingTop,
    bool? addable,
    this.callbackAdd,
    bool? isBottomsheet,
    this.maxCharacters,
    String? textUnlink,
    this.variant,
    bool? hasTitleText,
    this.titleText,
    this.colorText,
  })  : this.fieldId = fieldId ?? 'id',
        this.fieldName = fieldName ?? 'name',
        this.hasSearch = hasSearch ?? false,
        this.unlink = unlink ?? false,
        this.itemSpace = itemSpace ?? 0.0,
        this.paddingTop = paddingTop ?? 0.0,
        this.addable = addable ?? false,
        this.isBottomsheet = isBottomsheet ?? false,
        this.textUnlink = textUnlink ?? 'Desvincular',
        this.hasTitleText = hasTitleText ?? false;

  final List<dynamic>? list;
  final String fieldId;
  final String fieldName;
  final dynamic listSelected;
  final bool hasSearch;
  final bool unlink;
  final String? fieldDescription;
  final String? fieldImage;
  final int? width;
  final int? insideHeight;

  /// determina o espaçamento entre os itens.
  ///
  /// value default: 0.
  final double itemSpace;

  final double paddingTop;
  final bool addable;
  final Future Function(String name)? callbackAdd;
  final bool isBottomsheet;
  final int? maxCharacters;
  final String textUnlink;
  final Variant? variant;
  final bool hasTitleText;
  final String? titleText;
  final Color? colorText;

  @override
  State<DropDownSingleSelectWidget> createState() =>
      _DropDownSingleSelectWidgetState();
}

class _DropDownSingleSelectWidgetState extends State<DropDownSingleSelectWidget>
    with TickerProviderStateMixin {
  late DropDownSingleSelectModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DropDownSingleSelectModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.listSelectedDropDown = widget!.listSelected;
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
      padding:
          EdgeInsetsDirectional.fromSTEB(0.0, widget!.paddingTop, 0.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: () {
              if (widget!.isBottomsheet) {
                return valueOrDefault<double>(
                  MediaQuery.sizeOf(context).width,
                  400.0,
                );
              } else if (widget!.width != null) {
                return widget!.width?.toDouble();
              } else {
                return 400.0;
              }
            }(),
            constraints: BoxConstraints(
              maxHeight: 400.0,
            ),
            decoration: BoxDecoration(
              color: widget!.variant == Variant.dark
                  ? Color(0xFF1F1F1F)
                  : FlutterFlowTheme.of(context).tsNeutral0,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(valueOrDefault<double>(
                  widget!.isBottomsheet ? 0.0 : 8.0,
                  0.0,
                )),
                bottomRight: Radius.circular(valueOrDefault<double>(
                  widget!.isBottomsheet ? 0.0 : 8.0,
                  0.0,
                )),
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              border: Border.all(
                color: widget!.variant == Variant.dark
                    ? FlutterFlowTheme.of(context).tsNeutral800
                    : FlutterFlowTheme.of(context).tsNeutral200,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget!.hasTitleText)
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 0.0, 0.0),
                    child: Text(
                      valueOrDefault<String>(
                        widget!.titleText,
                        'Label',
                      ),
                      style: FlutterFlowTheme.of(context)
                          .tsFontSemiboldBase
                          .override(
                            font: GoogleFonts.roboto(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .tsFontSemiboldBase
                                  .fontStyle,
                            ),
                            color: () {
                              if (widget!.colorText != null) {
                                return widget!.colorText;
                              } else if (widget!.variant == Variant.dark) {
                                return FlutterFlowTheme.of(context)
                                    .tsTextInverter;
                              } else {
                                return FlutterFlowTheme.of(context)
                                    .tsTextDefault;
                              }
                            }(),
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .tsFontSemiboldBase
                                .fontStyle,
                          ),
                    ),
                  ),
                if (widget!.hasSearch)
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                    child: Container(
                      decoration: BoxDecoration(),
                      child: TextFormField(
                        controller: _model.textController,
                        focusNode: _model.textFieldFocusNode,
                        onChanged: (_) => EasyDebounce.debounce(
                          '_model.textController',
                          Duration(milliseconds: 10),
                          () async {
                            if (widget!.list
                                    ?.where(
                                        (e) => functions.filterSingleSelecte(
                                            e,
                                            valueOrDefault<String>(
                                              widget!.fieldName,
                                              'name',
                                            ),
                                            _model.textController.text))
                                    .toList()
                                    ?.length ==
                                0) {
                              _model.add = true;
                              safeSetState(() {});
                            } else {
                              _model.add = false;
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
                                color:
                                    FlutterFlowTheme.of(context).tsTextDefault,
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
                            '94lxwlzt' /* Digite para buscar */,
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
                  height: valueOrDefault<double>(
                    widget!.insideHeight?.toDouble(),
                    200.0,
                  ),
                  constraints: BoxConstraints(
                    maxHeight: 400.0,
                  ),
                  decoration: BoxDecoration(),
                  child: Builder(
                    builder: (context) {
                      if (widget!.addable && (widget!.list!.length > 0)) {
                        return Builder(
                          builder: (context) {
                            if (_model.add) {
                              return Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _model.textController.text,
                                        style: FlutterFlowTheme.of(context)
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
                                              color: widget!.variant ==
                                                      Variant.dark
                                                  ? FlutterFlowTheme.of(context)
                                                      .tsTextInverter
                                                  : FlutterFlowTheme.of(context)
                                                      .tsTextDefault,
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .tsFontNormalSm
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .tsFontNormalSm
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        Navigator.pop(
                                            context, <String, dynamic>{
                                          'name': getJsonField(
                                            <String, String?>{
                                              'value':
                                                  _model.textController.text,
                                            },
                                            r'''$.value''',
                                          ),
                                          'addable': getJsonField(
                                            <String, bool?>{
                                              'value': true,
                                            },
                                            r'''$.value''',
                                          ),
                                        });
                                      },
                                      text: FFLocalizations.of(context).getText(
                                        'npv718qd' /* adicionar */,
                                      ),
                                      icon: Icon(
                                        FFIcons.kplus,
                                        size: 15.0,
                                      ),
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        iconColor: FlutterFlowTheme.of(context)
                                            .tsPrimaryDefault,
                                        color: widget!.variant == Variant.dark
                                            ? FlutterFlowTheme.of(context)
                                                .tsNeutral900
                                            : FlutterFlowTheme.of(context)
                                                .tsNeutral0,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              font: GoogleFonts.interTight(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tsPrimaryDefault,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
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
                              );
                            } else {
                              return Builder(
                                builder: (context) {
                                  final dinamicListCheckBox = widget!.list!
                                      .where(
                                          (e) => functions.filterSingleSelecte(
                                              e,
                                              valueOrDefault<String>(
                                                widget!.fieldName,
                                                'name',
                                              ),
                                              _model.textController.text))
                                      .toList();

                                  return SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: List.generate(
                                          dinamicListCheckBox.length,
                                          (dinamicListCheckBoxIndex) {
                                        final dinamicListCheckBoxItem =
                                            dinamicListCheckBox[
                                                dinamicListCheckBoxIndex];
                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            _model.listSelectedDropDown =
                                                dinamicListCheckBoxItem;
                                            safeSetState(() {});
                                            if (widget!.isBottomsheet) {
                                              Navigator.pop(context,
                                                  _model.listSelectedDropDown);
                                            } else {
                                              Navigator.pop(context,
                                                  _model.listSelectedDropDown);
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(),
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    if ((widget!.fieldImage !=
                                                                null &&
                                                            widget!.fieldImage !=
                                                                '') &&
                                                        (functions.getDataFromField(
                                                                    dinamicListCheckBoxItem,
                                                                    widget!
                                                                        .fieldImage!) !=
                                                                null &&
                                                            functions.getDataFromField(
                                                                    dinamicListCheckBoxItem,
                                                                    widget!
                                                                        .fieldImage!) !=
                                                                ''))
                                                      Container(
                                                        width: 40.0,
                                                        height: 40.0,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Image.network(
                                                          'https://picsum.photos/seed/995/600',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    if ((widget!.fieldImage !=
                                                                null &&
                                                            widget!.fieldImage !=
                                                                '') &&
                                                        (functions.getDataFromField(
                                                                    dinamicListCheckBoxItem,
                                                                    widget!
                                                                        .fieldImage!) ==
                                                                null ||
                                                            functions.getDataFromField(
                                                                    dinamicListCheckBoxItem,
                                                                    widget!
                                                                        .fieldImage!) ==
                                                                ''))
                                                      Container(
                                                        width: 40.0,
                                                        height: 40.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: widget!
                                                                      .variant ==
                                                                  Variant.dark
                                                              ? FlutterFlowTheme
                                                                      .of(
                                                                          context)
                                                                  .tsNeutral800
                                                              : FlutterFlowTheme
                                                                      .of(context)
                                                                  .tsNeutral200,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      24.0),
                                                        ),
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Text(
                                                          (String name) {
                                                            return name
                                                                .trim()
                                                                .split(RegExp(
                                                                    r'\s+'))
                                                                .where((w) => w
                                                                    .isNotEmpty)
                                                                .map((w) => String
                                                                    .fromCharCode(w
                                                                        .runes
                                                                        .first))
                                                                .take(2)
                                                                .join()
                                                                .toUpperCase();
                                                          }(functions.getDataFromField(
                                                              dinamicListCheckBoxItem,
                                                              widget!
                                                                  .fieldName)),
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
                                                      ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          functions.getDataFromField(
                                                              dinamicListCheckBoxItem,
                                                              widget!
                                                                  .fieldName),
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
                                                        if (widget!.fieldDescription !=
                                                                null &&
                                                            widget!.fieldDescription !=
                                                                '')
                                                          Text(
                                                            functions.getDataFromField(
                                                                dinamicListCheckBoxItem,
                                                                widget!
                                                                    .fieldDescription!),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .tsFontNormalXs
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tsFontNormalXs
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tsFontNormalXs
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
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tsFontNormalXs
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tsFontNormalXs
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                      ].divide(SizedBox(
                                                          height: 4.0)),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 8.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).divide(
                                          SizedBox(height: widget!.itemSpace)),
                                    ),
                                  );
                                },
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
                                    valueOrDefault<String>(
                                      widget!.fieldName,
                                      'name',
                                    ),
                                    _model.textController.text))
                                .toList();

                            return SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children:
                                    List.generate(dinamicListCheckBox.length,
                                        (dinamicListCheckBoxIndex) {
                                  final dinamicListCheckBoxItem =
                                      dinamicListCheckBox[
                                          dinamicListCheckBoxIndex];
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.listSelectedDropDown =
                                          dinamicListCheckBoxItem;
                                      safeSetState(() {});
                                      Navigator.pop(
                                          context, _model.listSelectedDropDown);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              if ((widget!.fieldImage != null &&
                                                      widget!.fieldImage !=
                                                          '') &&
                                                  (functions.getDataFromField(
                                                              dinamicListCheckBoxItem,
                                                              widget!
                                                                  .fieldImage!) !=
                                                          null &&
                                                      functions.getDataFromField(
                                                              dinamicListCheckBoxItem,
                                                              widget!
                                                                  .fieldImage!) !=
                                                          ''))
                                                Container(
                                                  width: 40.0,
                                                  height: 40.0,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.network(
                                                    'https://picsum.photos/seed/995/600',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              if ((widget!.fieldImage != null &&
                                                      widget!.fieldImage !=
                                                          '') &&
                                                  (functions.getDataFromField(
                                                              dinamicListCheckBoxItem,
                                                              widget!
                                                                  .fieldImage!) ==
                                                          null ||
                                                      functions.getDataFromField(
                                                              dinamicListCheckBoxItem,
                                                              widget!
                                                                  .fieldImage!) ==
                                                          ''))
                                                Container(
                                                  width: 40.0,
                                                  height: 40.0,
                                                  decoration: BoxDecoration(
                                                    color: widget!.variant ==
                                                            Variant.dark
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .tsNeutral800
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .tsNeutral200,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24.0),
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Text(
                                                    (String name) {
                                                      return name
                                                          .trim()
                                                          .split(RegExp(r'\s+'))
                                                          .where((w) =>
                                                              w.isNotEmpty)
                                                          .map((w) => String
                                                              .fromCharCode(w
                                                                  .runes.first))
                                                          .take(2)
                                                          .join()
                                                          .toUpperCase();
                                                    }(functions.getDataFromField(
                                                        dinamicListCheckBoxItem,
                                                        widget!.fieldName)),
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
                                                ),
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    functions.getDataFromField(
                                                        dinamicListCheckBoxItem,
                                                        widget!.fieldName),
                                                    maxLines: 2,
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  if (widget!.fieldDescription !=
                                                          null &&
                                                      widget!.fieldDescription !=
                                                          '')
                                                    Text(
                                                      functions.getDataFromField(
                                                          dinamicListCheckBoxItem,
                                                          widget!
                                                              .fieldDescription!),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tsFontNormalXs
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .roboto(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tsFontNormalXs
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tsFontNormalXs
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
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tsFontNormalXs
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tsFontNormalXs
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                ].divide(SizedBox(height: 4.0)),
                                              ),
                                            ].divide(SizedBox(width: 8.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).divide(SizedBox(height: widget!.itemSpace)),
                              ),
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
                if (widget!.unlink)
                  Divider(
                    thickness: 1.0,
                    color: widget!.variant == Variant.dark
                        ? Color(0xFF1F1F1F)
                        : FlutterFlowTheme.of(context).tsNeutral300,
                  ),
                if (widget!.unlink)
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      _model.listSelectedDropDown = null;
                      safeSetState(() {});
                      Navigator.pop(context, <String, bool?>{
                        'reset': true,
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        maxHeight: 400.0,
                      ),
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              FFIcons.klinkBreak,
                              color: FlutterFlowTheme.of(context).tsDanger500,
                              size: 16.0,
                            ),
                            Text(
                              valueOrDefault<String>(
                                widget!.textUnlink,
                                'Desvincular',
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
                                        .tsDanger500,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .tsFontNormalSm
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .tsFontNormalSm
                                        .fontStyle,
                                  ),
                            ),
                          ].divide(SizedBox(width: 4.0)),
                        ),
                      ),
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
