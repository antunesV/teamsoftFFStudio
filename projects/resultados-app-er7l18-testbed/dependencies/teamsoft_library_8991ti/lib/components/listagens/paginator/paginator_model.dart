import '/backend/schema/enums/enums.dart';
import '/components/listagens/pagination/pagination_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'paginator_widget.dart' show PaginatorWidget;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PaginatorModel extends FlutterFlowModel<PaginatorWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for pagination component.
  late PaginationModel paginationModel;

  @override
  void initState(BuildContext context) {
    paginationModel = createModel(context, () => PaginationModel());
  }

  @override
  void dispose() {
    paginationModel.dispose();
  }
}
