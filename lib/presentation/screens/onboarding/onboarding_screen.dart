import 'package:ecommerce/presentation/screens/auth/login_screen.dart';
import 'package:ecommerce/presentation/screens/onboarding/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ecommerce/core/constants/app_strings.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  void _goToNextPage(int totalItems) {
    if (_currentIndex < totalItems - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      _navigateToLogin();
    }
  }

  void _skipOnboarding(int lastIndex) {
    _pageController.animateToPage(
      lastIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final items = getItems(context);

    final double isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape
        ? 0.5
        : 0.65;
    final double imageHeight = size.height * isLandscape;

    return Scaffold(
      // backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              // Top Image Section
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: imageHeight,
                width: size.width,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: items.length,
                  onPageChanged: (index) =>
                      setState(() => _currentIndex = index),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _buildImagePage(items[index]);
                  },
                ),
              ),

              // Bottom Control Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildPageIndicator(items.length),
                      _buildActionButtons(items.length, constraints),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildImagePage(Item item) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
            ),
            image: DecorationImage(
              image: AssetImage(item.img),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Center(
            child: FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: _buildTitleOverlay(item.title),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleOverlay(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Text(
        title.toUpperCase(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w900,
          color: Colors.black,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildPageIndicator(int count) {
    return SmoothPageIndicator(
      controller: _pageController,
      count: count,
      effect: const ExpandingDotsEffect(
        spacing: 8.0,
        radius: 4.0,
        dotWidth: 8.0,
        dotHeight: 8.0,
        expansionFactor: 4,
        dotColor: Colors.grey,
        activeDotColor: Color(0xffFA6E21),
      ),
      onDotClicked: (index) {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
    );
  }

  Widget _buildActionButtons(int totalItems, BoxConstraints constraints) {
    final buttonWidth = constraints.maxWidth > 600 ? 200.0 : double.infinity;

    if (_currentIndex == totalItems - 1) {
      return Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: ElevatedButton(
            onPressed: () => _goToNextPage(totalItems),
            style: _filledButtonStyle(),
            child: const Text(AppStrings.next, style: _buttonTextStyle),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: buttonWidth),
            child: OutlinedButton(
              onPressed: () => _skipOnboarding(totalItems - 1),
              style: _outlinedButtonStyle(),
              child: const Text(
                AppStrings.skip,
                style: TextStyle(
                  color: Color(0xffFA6E21),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: buttonWidth),
            child: ElevatedButton(
              onPressed: () => _goToNextPage(totalItems),
              style: _filledButtonStyle(),
              child: const Text(AppStrings.next, style: _buttonTextStyle),
            ),
          ),
        ),
      ],
    );
  }

  static const _buttonTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  ButtonStyle _filledButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xffFA6E21),
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0,
    );
  }

  ButtonStyle _outlinedButtonStyle() {
    return OutlinedButton.styleFrom(
      side: const BorderSide(color: Color(0xffFA6E21), width: 2),
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
