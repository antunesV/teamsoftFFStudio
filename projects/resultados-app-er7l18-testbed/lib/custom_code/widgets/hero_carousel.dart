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

import '/custom_code/widgets/index.dart';
import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'dart:async';

class HeroCarousel extends StatefulWidget {
  const HeroCarousel({
    super.key,
    this.width,
    this.height,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.titles,
    required this.verticalTexts,
    this.autoPlayMs = 5000,
  });

  final double? width;
  final double? height;

  final String image1;
  final String image2;
  final String image3;

  final List<String> titles;
  final List<String> verticalTexts;

  final int autoPlayMs;

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _progressController;
  late final List<String> _images;

  int _currentIndex = 0;

  static const _expoEase = Cubic(0.87, 0.0, 0.13, 1.0);

  /// 🔥 FORÇA REGISTRO DOS ASSETS NO BUNDLE
  /// Adicione aqui TODAS as imagens que podem ser usadas
  void _registerAssets(BuildContext context) {
    const AssetImage('assets/images/Image_1.png');
    const AssetImage('assets/images/Image_2.png');
    const AssetImage('assets/images/Image_3.png');
  }

  @override
  void initState() {
    super.initState();

    _images = [
      widget.image1,
      widget.image2,
      widget.image3,
    ];

    _pageController = PageController();

    _progressController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.autoPlayMs),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _handleCycle();
        }
      });

    _progressController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _registerAssets(context); // 🔥 Força inclusão no build
  }

  Future<void> _handleCycle() async {
    final next = (_currentIndex + 1) % _images.length;

    setState(() {
      _currentIndex = next;
    });

    _pageController.animateToPage(
      next,
      duration: const Duration(milliseconds: 700),
      curve: _expoEase,
    );

    _progressController
      ..reset()
      ..forward();
  }

  Widget _buildImage(String path) {
    return Image.asset(
      path,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.height ?? 420;

    return SizedBox(
      width: widget.width ?? double.infinity,
      height: height,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _images.length,
            itemBuilder: (_, index) {
              return SizedBox.expand(
                child: _buildImage(_images[index]),
              );
            },
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.3, 0.7, 1.0],
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.0),
                  Color.fromRGBO(0, 0, 0, 0.5),
                  Color.fromRGBO(0, 0, 0, 1.0),
                  Color.fromRGBO(0, 0, 0, 1.0),
                ],
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 38,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIndicators(),
                const SizedBox(height: 12),
                Text(
                  widget.titles[_currentIndex],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicators() {
    return Row(
      children: List.generate(_images.length, (index) {
        final isActive = index == _currentIndex;

        return Container(
          margin: const EdgeInsets.only(right: 8),
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            color: Colors.white,
          ),
          child: isActive
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: AnimatedBuilder(
                    animation: _progressController,
                    builder: (_, __) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: _progressController.value,
                          child: Container(
                            color: const Color(0xFF57DBA7),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : null,
        );
      }),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressController.dispose();
    super.dispose();
  }
}
