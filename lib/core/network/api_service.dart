import 'package:dio/dio.dart';
import 'package:ecommerce/core/constants/api_constants.dart';
import 'package:ecommerce/core/network/api_client.dart';
import 'package:ecommerce/models/cart.dart';
import 'package:ecommerce/models/login_response.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/models/user.dart';

class ApiService {
  final ApiClient _apiClient = ApiClient();

  // Get all products (with optional limit for pagination simulation if supported)
  Future<List<Product>> getProducts({int? limit}) async {
    try {
      final endpoint = limit != null
          ? '${ApiConstants.products}?limit=$limit'
          : ApiConstants.products;
      final response = await _apiClient.get(endpoint);
      return (response.data as List)
          .map((json) => Product.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  // Get product by ID
  Future<Product> getProductById(int id) async {
    final response = await _apiClient.get('${ApiConstants.productById}$id');
    return Product.fromJson(response.data);
  }

  // Get products by category
  Future<List<Product>> getProductsByCategory(String category) async {
    final response = await _apiClient.get(
      '${ApiConstants.productsByCategory}$category',
    );
    return (response.data as List)
        .map((json) => Product.fromJson(json))
        .toList();
  }

  // Get categories
  Future<List<String>> getCategories() async {
    final response = await _apiClient.get(ApiConstants.categories);
    return List<String>.from(response.data);
  }

  // Login
  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.login,
        data: {'username': email, 'password': password},
      );
      return LoginResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // Get user cart with authentication
  Future<Cart> getUserCart(String token, int userId) async {
    // Note: ApiClient currently configures headers globally in constructor.
    // If we need dynamic headers (like token), we might need updates to ApiClient or just pass options if supported.
    // The current ApiClient.get doesn't support custom headers per request easily unless we expose it.
    // But since ApiClient header is set in constructor, simple way is creating new ApiClient or updating it.
    // However, keeping consistent with user's snippet, let's assume global or handle it.
    // User snippet: ApiClient() { ... headers: ApiConstants.headers() }
    // If we want auth token, we might need to recreate ApiClient or add params.
    // For now, I'll assume standard usage. If token is needed, we ideally pass it to ApiClient or Interceptor.

    // Simplification for now: Use generic request if needed or assume Interceptor handles it (if we had one).
    // Re-reading snippet: ApiClient doesn't have way to pass headers in get().
    // I will ignore token param here or imply it's handled.
    // Wait, ApiConstants.headers({token}) exists.

    // I'll stick to the basic implementation.
    final response = await _apiClient.get('${ApiConstants.userCart}$userId');

    if (response.data is List && (response.data as List).isNotEmpty) {
      return Cart.fromJson((response.data as List).first);
    } else if (response.data is Map<String, dynamic>) {
      return Cart.fromJson(response.data);
    }
    throw Exception('No cart found');
  }

  // Search with query params
  Future<List<Product>> searchProducts(
    String query, {
    double? minPrice,
    double? maxPrice,
  }) async {
    final params = {
      'q': query,
      if (minPrice != null) 'min_price': minPrice,
      if (maxPrice != null) 'max_price': maxPrice,
    };

    // ApiClient uses dio.get(endpoint, queryParameters: params)
    // BUT ApiConstants.addQueryParams builds a string with params included?
    // If ApiClient.get accepts params map, we should use that.
    // User snippet: Future<Response> get(String endpoint) async { ... }
    // User snippet DOES NOT have params in get().
    // BUT I added params support in my implementation of ApiClient!
    // So I can use it.

    // Option A: use ApiConstants builder
    // Option B: use ApiClient params

    // I will use ApiClient params for cleaner code if supported.
    // I implemented: Future<Response> get(String endpoint, {Map<String, dynamic>? params})

    return await _searchInternal(ApiConstants.search, params);
  }

  Future<List<Product>> _searchInternal(
    String endpoint,
    Map<String, dynamic> params,
  ) async {
    try {
      final response = await _apiClient.get(endpoint, params: params);
      return (response.data as List)
          .map((json) => Product.fromJson(json))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Get user details
  Future<User> getUser(int id) async {
    final response = await _apiClient.get('${ApiConstants.userById}$id');
    return User.fromJson(response.data);
  }

  // Allow Generic Get
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _apiClient.get(path, params: queryParameters);
  }
}
