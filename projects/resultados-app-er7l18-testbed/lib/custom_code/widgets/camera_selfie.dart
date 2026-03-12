// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import "package:teamsoft_library_8991ti/backend/schema/structs/index.dart"
    as teamsoft_library_8991ti_data_schema;
import "package:teamsoft_library_8991ti/backend/schema/enums/enums.dart"
    as teamsoft_library_8991ti_enums;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

class CameraSelfie extends StatefulWidget {
  const CameraSelfie({
    super.key,
    required this.width,
    required this.height,
    this.onPictureTaken,
  });

  final double width;
  final double height;

  final Future<void> Function(FFUploadedFile uploadedFile)? onPictureTaken;

  static const double _borderWidth = 2.0;

  @override
  State<CameraSelfie> createState() => _CameraSelfieState();
}

class _CameraSelfieState extends State<CameraSelfie> {
  CameraController? _controller;
  CameraLensDirection _lens = CameraLensDirection.front;

  static const double _ellipseRatio = 43 / 82;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _initCamera();
    }
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();

    final camera = cameras.firstWhere(
      (c) => c.lensDirection == _lens,
    );

    await _controller?.dispose();

    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _controller!.initialize();

    if (mounted) setState(() {});
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      final file = await _controller!.takePicture();
      final bytes = await file.readAsBytes();

      final uploadedFile = FFUploadedFile(
        name: file.name,
        bytes: bytes,
      );

      if (widget.onPictureTaken != null) {
        await widget.onPictureTaken!(uploadedFile);
      }
    } catch (e) {
      debugPrint('Erro ao capturar imagem: $e');
    }
  }

  void _switchCamera() {
    _lens = _lens == CameraLensDirection.front
        ? CameraLensDirection.back
        : CameraLensDirection.front;

    _initCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildPreview(double containerWidth, double containerHeight) {
    final previewRatio = _controller!.value.aspectRatio;

    final previewWidth = containerHeight * previewRatio;

    return ClipRect(
      child: SizedBox(
        width: containerWidth,
        height: containerHeight,
        child: OverflowBox(
          alignment: Alignment.center,
          minHeight: containerHeight,
          maxHeight: containerHeight,
          minWidth: previewWidth,
          maxWidth: previewWidth,
          child: CameraPreview(_controller!),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double safeMargin = 24;

    final availableWidth = widget.width - safeMargin;

    final ellipseWidth = availableWidth * 0.75;

    final ellipseHeight = min(
      ellipseWidth / _ellipseRatio,
      widget.height * 0.85,
    );

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: SizedBox(
                width: ellipseWidth,
                height: ellipseHeight,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipOval(
                      child: _controller != null &&
                              _controller!.value.isInitialized
                          ? _buildPreview(
                              ellipseWidth,
                              ellipseHeight,
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                    CustomPaint(
                      size: Size(ellipseWidth, ellipseHeight),
                      painter: const _EllipseBorderPainter(
                        borderWidth: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Área inferior controles
          Container(
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 48),
                GestureDetector(
                  onTap: _takePicture,
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _switchCamera,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.cameraswitch,
                      color: Colors.white,
                      size: 22,
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

class _EllipseBorderPainter extends CustomPainter {
  const _EllipseBorderPainter({
    required this.borderWidth,
  });

  final double borderWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      borderWidth / 2,
      borderWidth / 2,
      size.width - borderWidth,
      size.height - borderWidth,
    );

    final paint = Paint()
      ..color = const Color.fromRGBO(255, 255, 255, 0.95)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..isAntiAlias = true;

    canvas.drawOval(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
