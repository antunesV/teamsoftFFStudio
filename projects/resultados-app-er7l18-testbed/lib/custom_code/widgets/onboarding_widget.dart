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

class onboardingWidget extends StatefulWidget {
  const onboardingWidget({
    super.key,
    required this.logoLeftPath,
    required this.logoRightPath,
    required this.carouselImages,
    required this.sideTexts,
    required this.titles,
    this.carouselHeight = 420,
    this.onCreateAccount,
    this.onLogin,
  });

  final String logoLeftPath;
  final String logoRightPath;

  final List<String> carouselImages;
  final List<String> sideTexts;
  final List<String> titles;

  final double carouselHeight;

  final Future<void> Function()? onCreateAccount;
  final Future<void> Function()? onLogin;

  @override
  State<onboardingWidget> createState() => _OnboardingResultsWidgetState();
}

class _OnboardingResultsWidgetState extends State<onboardingWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0E2F23),
            Color(0xFF000000),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildCarousel(),
            const Spacer(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Image.asset(widget.logoLeftPath, height: 36),
          const SizedBox(width: 12),
          Image.asset(widget.logoRightPath, height: 20),
        ],
      ),
    );
  }

  // ================= CAROUSEL =================
  Widget _buildCarousel() {
    return SizedBox(
      height: widget.carouselHeight,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.carouselImages.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              return _buildCarouselItem(index);
            },
          ),

          // Indicador
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: _buildIndicator(),
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Stack(
        children: [
          // Imagem
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                widget.carouselImages[index],
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Degradê bottom -> top
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black87,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Texto vertical com glow
          Positioned(
            right: 0,
            top: 40,
            bottom: 40,
            child: RotatedBox(
              quarterTurns: 3,
              child: Text(
                widget.sideTexts[index],
                style: TextStyle(
                  fontSize: 22,
                  letterSpacing: 2,
                  color: Colors.white.withOpacity(0.7),
                  shadows: const [
                    Shadow(
                      blurRadius: 12,
                      color: Color(0xFF2ED39F),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Texto principal
          Positioned(
            left: 24,
            right: 24,
            bottom: 60,
            child: Text(
              widget.titles[index],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= INDICATOR =================
  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.carouselImages.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentIndex == index ? 20 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: _currentIndex == index
                ? const Color(0xFF2ED39F)
                : Colors.white24,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }

  // ================= FOOTER =================
  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          GestureDetector(
            onTap: widget.onCreateAccount,
            child: const Text(
              'Abra sua conta',
              style: TextStyle(
                color: Color(0xFF2ED39F),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: widget.onLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2ED39F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                'Acesse sua conta',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
