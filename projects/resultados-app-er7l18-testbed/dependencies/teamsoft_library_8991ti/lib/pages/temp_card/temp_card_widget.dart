import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'temp_card_model.dart';
export 'temp_card_model.dart';

class TempCardWidget extends StatefulWidget {
  const TempCardWidget({
    super.key,
    required this.width,
    this.height,
  });

  final int? width;
  final int? height;

  @override
  State<TempCardWidget> createState() => _TempCardWidgetState();
}

class _TempCardWidgetState extends State<TempCardWidget> {
  late TempCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TempCardModel());

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
      width: valueOrDefault<double>(
        widget!.width?.toDouble(),
        100.0,
      ),
      height: valueOrDefault<double>(
        widget!.height?.toDouble(),
        100.0,
      ),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
    );
  }
}
