import 'package:ecommerce/core/network/api_service.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Service Provider
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

// Products Provider
final productsProvider = FutureProvider<List<Product>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return await apiService.getProducts();
});

// Products by Category Provider (Family)
final productsByCategoryProvider = FutureProvider.family<List<Product>, String>(
  (ref, category) async {
    final apiService = ref.watch(apiServiceProvider);
    return await apiService.getProductsByCategory(category);
  },
);

// Single Product Provider (Family)
final productDetailsProvider = FutureProvider.family<Product, int>((
  ref,
  id,
) async {
  final apiService = ref.watch(apiServiceProvider);
  return await apiService.getProductById(id);
});

// Search Provider
final searchProvider = FutureProvider.family<List<Product>, String>((
  ref,
  query,
) async {
  if (query.isEmpty) return [];
  final apiService = ref.watch(apiServiceProvider);
  // Debounce is handled in UI or here if using a delayed provider, but UI debounce is safer for family.
  return await apiService.searchProducts(query);
});

// Search State Providers for easier UI integration
final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = FutureProvider<List<Product>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  return ref.watch(searchProvider(query).future);
});
