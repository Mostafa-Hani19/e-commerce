import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ecommerce/core/routes/app_routes.dart';
import 'package:ecommerce/presentation/screens/splash/splash_screen.dart';
import 'package:ecommerce/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:ecommerce/presentation/screens/auth/login_screen.dart';
import 'package:ecommerce/presentation/screens/auth/sign_up_screen.dart'; // Corrected import
import 'package:ecommerce/presentation/screens/auth/forgot_password_screen.dart';
import 'package:ecommerce/presentation/screens/auth/verification_code_sheet.dart'; // Corrected import
import 'package:ecommerce/presentation/screens/auth/new_password_screen.dart'; // Added import
import 'package:ecommerce/presentation/screens/home/home_screen.dart';
import 'package:ecommerce/presentation/screens/cart/cart_screen.dart';
import 'package:ecommerce/presentation/screens/search/search_screen.dart';
import 'package:ecommerce/presentation/screens/search/camera_search_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.onboarding:
        return MaterialPageRoute(
          builder: (_) => const IntroductionScreen(),
        ); // Corrected class name
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case AppRoutes.verification:
        return MaterialPageRoute(
          builder: (_) => const VerificationCodeSheet(),
        ); // Corrected class name
      case AppRoutes.newPassword:
        return MaterialPageRoute(
          builder: (_) => const NewPasswordScreen(),
        ); // Added route
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.cart:
        return CupertinoPageRoute(builder: (_) => const CartScreen());
      case AppRoutes.search:
        return CupertinoPageRoute(builder: (_) => const SearchScreen());
      case AppRoutes.cameraSearch:
        return CupertinoPageRoute(builder: (_) => const CameraSearchScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: const Center(child: Text('ERROR: Route not found')),
        );
      },
    );
  }
}
