import 'package:ecommerce/core/constants/app_images.dart';
import 'package:ecommerce/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  static const _animationDuration = Duration(seconds: 3);
  static const _navigationDelay = Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    _initAnimation();
    _navigateToNextScreen();
  }

  void _initAnimation() {
    _controller = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );

    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  void _navigateToNextScreen() {
    Future.delayed(_navigationDelay, () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const IntroductionScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double logoWidth = size.width * 0.4; // 40% of screen width

    return Scaffold(
      // backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _opacity,
          child: SizedBox(
            width: logoWidth > 300 ? 300 : logoWidth, // Max cap 300
            child: Image.asset(AppImages.logo, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
