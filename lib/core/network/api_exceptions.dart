import 'package:dio/dio.dart';

class ApiExceptions implements Exception {
  final String message;

  ApiExceptions(this.message);

  @override
  String toString() => message;

  static ApiExceptions handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiExceptions('Connection timeout. Please try again.');

      case DioExceptionType.sendTimeout:
        return ApiExceptions('Send timeout. Please try again.');

      case DioExceptionType.receiveTimeout:
        return ApiExceptions('Receive timeout. Please try again.');

      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);

      case DioExceptionType.cancel:
        return ApiExceptions('Request cancelled.');

      case DioExceptionType.connectionError:
        return ApiExceptions('No internet connection.');

      case DioExceptionType.unknown:
        return ApiExceptions('Unexpected error occurred. Please try again.');

      default:
        return ApiExceptions('Something went wrong.');
    }
  }

  static ApiExceptions _handleBadResponse(Response? response) {
    if (response == null) {
      return ApiExceptions('Unknown bad response.');
    }

    final statusCode = response.statusCode;
    final message = response.data
        .toString(); // Simplify for now, ideally parse JSON error

    switch (statusCode) {
      case 400:
        return ApiExceptions('Bad Request: $message');
      case 401:
        return ApiExceptions('Unauthorized. Please login again.');
      case 403:
        return ApiExceptions('Forbidden. You do not have permission.');
      case 404:
        return ApiExceptions('Resource not found.');
      case 500:
        return ApiExceptions('Internal Server Error. Please try again later.');
      case 502:
        return ApiExceptions('Bad Gateway.');
      default:
        return ApiExceptions('Error $statusCode: $message');
    }
  }
}
