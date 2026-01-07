import 'package:ecommerce/core/network/api_service.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce/core/providers/product_provider.dart'; // for apiServiceProvider

class PaginationState<T> {
  final List<T> items;
  final bool isLoading;
  final bool hasMore;
  final String? error;

  const PaginationState({
    this.items = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.error,
  });

  PaginationState<T> copyWith({
    List<T>? items,
    bool? isLoading,
    bool? hasMore,
    String? error,
  }) {
    return PaginationState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      error: error,
    );
  }
}

class PaginatedProductsNotifier
    extends StateNotifier<PaginationState<Product>> {
  final ApiService _apiService;
  int _page = 1;
  final int _limit = 6; // Small limit to demonstrate pagination

  PaginatedProductsNotifier(this._apiService) : super(const PaginationState()) {
    fetchFirstPage();
  }

  Future<void> fetchFirstPage() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // FakeStore doesn't support true offset pagination, so we simulate it.
      // In a real app we'd pass _page and _limit.
      // Here we fetch 'enough' or just different endpoint if possible.
      // We will simulate by just fetching "limit" items.

      // Attempting to simulate: fetch ALL, then slice locally?
      // User asked for "Professional Way" which usually implies Server-Side.
      // Since Server doesn't support it, I will implement the Architecture correctly
      // but maybe just fetch 'limit * page'.

      final products = await _apiService.getProducts(limit: _limit * _page);

      state = state.copyWith(
        items: products,
        isLoading: false,
        hasMore:
            products.length ==
            _limit * _page, // If we got full limit, likely more exist
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true, error: null);
    _page++;

    try {
      // Simulate fetching "next page" by increasing limit
      final products = await _apiService.getProducts(limit: _limit * _page);

      // If we got same count as before (or less than index), no more data
      if (products.length <= state.items.length) {
        state = state.copyWith(isLoading: false, hasMore: false);
        return;
      }

      state = state.copyWith(items: products, isLoading: false, hasMore: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final paginatedProductsProvider =
    StateNotifierProvider<PaginatedProductsNotifier, PaginationState<Product>>((
      ref,
    ) {
      final apiService = ref.watch(apiServiceProvider);
      return PaginatedProductsNotifier(apiService);
    });
