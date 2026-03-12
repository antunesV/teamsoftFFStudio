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

class FFDebugPanel extends StatefulWidget {
  const FFDebugPanel({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  State<FFDebugPanel> createState() => _FFDebugPanelState();
}

class _FFDebugPanelState extends State<FFDebugPanel> {
  static final List<String> _logs = [];
  static bool _visible = true;

  final ScrollController _scrollController = ScrollController();

  static void log(String message) {
    final time =
        "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
    _logs.add("[$time] $message");
  }

  void _clearLogs() {
    setState(() {
      _logs.clear();
    });
  }

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) {
      return Align(
        alignment: Alignment.bottomRight,
        child: GestureDetector(
          onTap: _toggle,
          child: Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.bug_report,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      );
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: widget.width ?? double.infinity,
        height: widget.height ?? 250,
        decoration: const BoxDecoration(
          color: Color(0xEE000000),
        ),
        child: Column(
          children: [
            /// HEADER
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              color: Colors.black,
              child: Row(
                children: [
                  const Icon(Icons.bug_report, color: Colors.green),
                  const SizedBox(width: 8),
                  const Text(
                    "FlutterFlow Debug Panel",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    onPressed: _clearLogs,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: _toggle,
                  ),
                ],
              ),
            ),

            /// LOG LIST
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _logs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    child: Text(
                      _logs[index],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.greenAccent,
                        fontFamily: 'monospace',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
