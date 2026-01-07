import 'package:dio/dio.dart';
import 'package:ecommerce/core/constants/global_keys.dart';
import 'package:ecommerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppDioInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMsg = '';

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorMsg = 'Connection timed out. Please check your internet.';
        break;
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        if (statusCode == 401) {
          errorMsg = 'Session expired. Please login again.';
          // Here you could also trigger a navigation to login using GlobalKeys.navigatorKey
        } else if (statusCode == 403) {
          errorMsg = 'Access denied.';
        } else if (statusCode == 404) {
          errorMsg = 'Resource not found.';
        } else if (statusCode == 500) {
          errorMsg = 'Server error. Please try again later.';
        } else {
          errorMsg = 'Something went wrong ($statusCode).';
        }
        break;
      case DioExceptionType.connectionError:
        errorMsg = 'No internet connection.';
        break;
      default:
        errorMsg = 'An unexpected error occurred.';
        break;
    }

    // Show Snackbar globally
    // We check if the widget binding allows it (safe check)
    if (errorMsg.isNotEmpty) {
      _showErrorSnackbar(errorMsg);
    }

    return handler.next(err);
  }

  void _showErrorSnackbar(String message) {
    final messenger = GlobalKeys.scaffoldMessengerKey.currentState;
    if (messenger != null) {
      messenger.showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(child: Text(message)),
            ],
          ),
          backgroundColor: AppTheme.redColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
