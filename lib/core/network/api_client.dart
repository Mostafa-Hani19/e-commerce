import 'package:dio/dio.dart';
import 'package:ecommerce/core/network/dio_interceptor.dart';
import '../constants/api_constants.dart';
import 'api_exceptions.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: ApiConstants.headers(),
      ),
    );

    // Add logging
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
        error: true,
      ),
    );
    // Add Global Error Interceptor
    _dio.interceptors.add(AppDioInterceptor());
  }

  // GET Request
  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      return await _dio.get(endpoint, queryParameters: params);
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  // POST Request
  Future<Response> post(String endpoint, {dynamic data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  // PUT Request
  Future<Response> put(String endpoint, {dynamic data}) async {
    try {
      return await _dio.put(endpoint, data: data);
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  // DELETE Request
  Future<Response> delete(String endpoint) async {
    try {
      return await _dio.delete(endpoint);
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }
}
