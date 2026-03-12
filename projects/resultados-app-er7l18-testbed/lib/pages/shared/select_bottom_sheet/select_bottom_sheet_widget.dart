import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'select_bottom_sheet_model.dart';
export 'select_bottom_sheet_model.dart';

class SelectBottomSheetWidget extends StatefulWidget {
  const SelectBottomSheetWidget({
    super.key,
    double? height,
    this.bottomsheetTitle,
    bool? hasSearch,
    this.searchText,
    this.jsonData,
    this.listviewItemSpacing,
    this.listviewPadding,
    this.searchParameters,
    bool? countryList,
    this.checkbox,
    this.selectedOptionAction,
  })  : this.height = height ?? 400.0,
        this.hasSearch = hasSearch ?? false,
        this.countryList = countryList ?? false;

  /// Height do bottom sheet em pixels
  final double height;

  /// Define se o bottom sheet vai ter título ou não
  final String? bottomsheetTitle;

  /// Define se possui campo de pesquisa
  final bool hasSearch;

  /// O texto do campo de pesquisa
  final String? searchText;

  /// Json com os itens que serão exibidos no List view
  final dynamic jsonData;

  /// espaço entre os itens do list view
  final double? listviewItemSpacing;

  /// padding do list view
  final double? listviewPadding;

  final List<dynamic>? searchParameters;
  final bool countryList;
  final dynamic checkbox;
  final Future Function(dynamic selectedOption)? selectedOptionAction;

  @override
  State<SelectBottomSheetWidget> createState() =>
      _SelectBottomSheetWidgetState();
}

class _SelectBottomSheetWidgetState extends State<SelectBottomSheetWidget> {
  late SelectBottomSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectBottomSheetModel());

    _model.searchTextController ??= TextEditingController();
    _model.searchFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: valueOrDefault<double>(
        widget!.height,
        400.0,
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 1.0,
      ),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).tsNeutral1000,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 59.0,
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: Color(0x27FFFFFF),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget!.bottomsheetTitle != null &&
                      widget!.bottomsheetTitle != '')
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'nt3wxoiz' /* Título */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .tsFontSemiboldBase
                                .override(
                                  font: GoogleFonts.lato(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .tsFontSemiboldBase
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).tsNeutral600,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .tsFontSemiboldBase
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                    ),
                  if (widget!.hasSearch)
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              width: 200.0,
                              child: TextFormField(
                                controller: _model.searchTextController,
                                focusNode: _model.searchFocusNode,
                                onChanged: (_) => EasyDebounce.debounce(
                                  '_model.searchTextController',
                                  Duration(milliseconds: 1),
                                  () => safeSetState(() {}),
                                ),
                                autofocus: false,
                                enabled: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: widget!.searchText,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x33FFFFFF),
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  filled: true,
                                  fillColor: Color(0x19FFFFFF),
                                  suffixIcon: Icon(
                                    FFIcons.kmagnifyingGlass,
                                    color: FlutterFlowTheme.of(context)
                                        .tsNeutral300,
                                    size: 24.0,
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .tsFontNormalSm
                                    .override(
                                      font: GoogleFonts.lato(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .tsFontNormalSm
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .tsFontNormalSm
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .tsNeutral300,
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
                                    FlutterFlowTheme.of(context).primaryText,
                                enableInteractiveSelection: true,
                                validator: _model.searchTextControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  SingleChildScrollView(
                    primary: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Builder(
                          builder: (context) {
                            final data = (widget!.hasSearch
                                        ? functions.searchFilter(
                                            _model.searchTextController.text,
                                            widget!.jsonData!,
                                            widget!.searchParameters!.toList())
                                        : widget!.jsonData)
                                    ?.toList() ??
                                [];

                            return ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: data.length,
                              separatorBuilder: (_, __) => SizedBox(
                                  height: valueOrDefault<double>(
                                widget!.listviewItemSpacing,
                                16.0,
                              )),
                              itemBuilder: (context, dataIndex) {
                                final dataItem = data[dataIndex];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      valueOrDefault<double>(
                                        widget!.listviewPadding,
                                        12.0,
                                      ),
                                      12.0,
                                      valueOrDefault<double>(
                                        widget!.listviewPadding,
                                        12.0,
                                      ),
                                      12.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      await widget.selectedOptionAction?.call(
                                        dataItem,
                                      );
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        if (widget!.countryList)
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: 36.0,
                                                height: 36.0,
                                                child: custom_widgets
                                                    .EmojiFlagCircle(
                                                  width: 36.0,
                                                  height: 36.0,
                                                  countryCode: getJsonField(
                                                    dataItem,
                                                    r'''$.iso''',
                                                  ).toString(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                getJsonField(
                                                  dataItem,
                                                  r'''$.title''',
                                                ).toString(),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .tsFontMediumSm
                                                    .override(
                                                      font: GoogleFonts.lato(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tsFontMediumSm
                                                                .fontStyle,
                                                      ),
                                                      color: colorFromCssString(
                                                        getJsonField(
                                                          dataItem,
                                                          r'''$.titleColor''',
                                                        ).toString(),
                                                        defaultColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tsNeutral300,
                                                      ),
                                                      fontSize: 14.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tsFontMediumSm
                                                              .fontStyle,
                                                    ),
                                              ),
                                              if (getJsonField(
                                                    dataItem,
                                                    r'''$.subtitle''',
                                                  ) !=
                                                  null)
                                                Text(
                                                  getJsonField(
                                                    dataItem,
                                                    r'''$.subtitle''',
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .tsFontNormalXs
                                                      .override(
                                                        font: GoogleFonts.lato(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .tsFontNormalXs
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .tsFontNormalXs
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            colorFromCssString(
                                                          getJsonField(
                                                            dataItem,
                                                            r'''$.subtitlecolor''',
                                                          ).toString(),
                                                          defaultColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .tsNeutral600,
                                                        ),
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tsFontNormalXs
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tsFontNormalXs
                                                                .fontStyle,
                                                      ),
                                                ),
                                            ].divide(SizedBox(
                                                height: valueOrDefault<double>(
                                              widget!.listviewItemSpacing,
                                              0.0,
                                            ))),
                                          ),
                                        ),
                                        if (widget!.checkbox != null)
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Theme(
                                                data: ThemeData(
                                                  checkboxTheme:
                                                      CheckboxThemeData(
                                                    visualDensity:
                                                        VisualDensity.compact,
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              valueOrDefault<
                                                                  double>(
                                                        getJsonField(
                                                          widget!.checkbox,
                                                          r'''$.borderRadius''',
                                                        ),
                                                        0.0,
                                                      )),
                                                    ),
                                                  ),
                                                  unselectedWidgetColor:
                                                      colorFromCssString(
                                                    getJsonField(
                                                      widget!.checkbox,
                                                      r'''$.checkBorderColor''',
                                                    ).toString(),
                                                    defaultColor: Colors.black,
                                                  ),
                                                ),
                                                child: Checkbox(
                                                  value:
                                                      _model.checkboxValueMap[
                                                          dataItem] ??= false,
                                                  onChanged: (newValue) async {
                                                    safeSetState(() => _model
                                                            .checkboxValueMap[
                                                        dataItem] = newValue!);
                                                  },
                                                  side: (colorFromCssString(
                                                            getJsonField(
                                                              widget!.checkbox,
                                                              r'''$.checkBorderColor''',
                                                            ).toString(),
                                                            defaultColor:
                                                                Colors.black,
                                                          ) !=
                                                          null)
                                                      ? BorderSide(
                                                          width: 2,
                                                          color:
                                                              colorFromCssString(
                                                            getJsonField(
                                                              widget!.checkbox,
                                                              r'''$.checkBorderColor''',
                                                            ).toString(),
                                                            defaultColor:
                                                                Colors.black,
                                                          )!,
                                                        )
                                                      : null,
                                                  activeColor:
                                                      colorFromCssString(
                                                    getJsonField(
                                                      widget!.checkbox,
                                                      r'''$.checkedColor''',
                                                    ).toString(),
                                                    defaultColor: Colors.black,
                                                  ),
                                                  checkColor:
                                                      colorFromCssString(
                                                    getJsonField(
                                                      widget!.checkbox,
                                                      r'''$.checkColor''',
                                                    ).toString(),
                                                    defaultColor: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                      ].divide(SizedBox(width: 4.0)),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
