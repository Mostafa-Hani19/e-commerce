class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://fakestoreapi.com';

  // API Version
  static const String apiVersion = '/v1';

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // ========== Products Endpoints ==========
  static const String products = '/products';
  static const String productById = '/products/'; // + id
  static const String categories = '/products/categories';
  static const String productsByCategory =
      '/products/category/'; // + category name

  // Specific categories
  static const String mensClothing = '/products/category/men\'s clothing';
  static const String womensClothing = '/products/category/women\'s clothing';
  static const String electronics = '/products/category/electronics';
  static const String jewelery = '/products/category/jewelery';

  // ========== Authentication Endpoints ==========
  static const String login = '/auth/login';
  static const String register =
      '/users'; // FakeStore uses /users for creating user
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password'; // Placeholder
  static const String resetPassword = '/auth/reset-password'; // Placeholder

  // ========== User Endpoints ==========
  static const String users = '/users';
  static const String userProfile = '/users/profile'; // Placeholder
  static const String updateProfile = '/users/profile/update'; // Placeholder
  static const String userById = '/users/'; // + id

  // ========== Cart Endpoints ==========
  static const String carts = '/carts';
  static const String userCart = '/carts/user/'; // + userId
  static const String addToCart = '/carts';
  static const String updateCart = '/carts/'; // + cartId
  static const String deleteCart = '/carts/'; // + cartId

  // ========== Orders Endpoints ==========
  static const String orders =
      '/orders'; // FakeStore doesn't strictly have orders, this is placeholder structure
  static const String orderById = '/orders/';
  static const String userOrders = '/orders/user/';
  static const String createOrder = '/orders/create';
  static const String cancelOrder = '/orders/cancel/';

  // ========== Wishlist Endpoints ==========
  static const String wishlist = '/wishlist';
  static const String addToWishlist = '/wishlist/add';
  static const String removeFromWishlist = '/wishlist/remove/';

  // ========== Reviews Endpoints ==========
  static const String reviews = '/reviews';
  static const String productReviews = '/reviews/product/';
  static const String addReview = '/reviews/add';

  // ========== Search & Filter ==========
  static const String search =
      '/products/search'; // FakeStore doesn't support search, but we keep the constant
  static const String filter = '/products/filter';

  // ========== Payment Endpoints ==========
  static const String payment = '/payment';
  static const String paymentMethods = '/payment/methods';
  static const String processPayment = '/payment/process';

  // ========== Addresses Endpoints ==========
  static const String addresses = '/addresses';
  static const String addAddress = '/addresses/add';
  static const String updateAddress = '/addresses/update/';
  static const String deleteAddress = '/addresses/delete/';

  // ========== Headers ==========
  static Map<String, String> headers({String? token}) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // ========== Query Parameters Helpers ==========
  static String addQueryParams(String endpoint, Map<String, dynamic> params) {
    if (params.isEmpty) return endpoint;

    final query = params.entries.map((e) => '${e.key}=${e.value}').join('&');

    return '$endpoint?$query';
  }

  // ========== Full URL Builder ==========
  static String getFullUrl(String endpoint) {
    return '$baseUrl$endpoint';
  }
}
