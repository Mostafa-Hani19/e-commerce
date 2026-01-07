import 'package:ecommerce/core/network/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final categoriesProvider = FutureProvider<List<String>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return await apiService.getCategories();
});
