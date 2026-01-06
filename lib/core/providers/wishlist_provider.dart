import 'package:ecommerce/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateNotifier to manage the list of favorite products
class WishlistNotifier extends StateNotifier<List<Product>> {
  WishlistNotifier() : super([]);

  void toggleFavorite(Product product) {
    if (state.any((item) => item.id == product.id)) {
      // Remove if exists
      state = state.where((item) => item.id != product.id).toList();
    } else {
      // Add if not exists
      state = [...state, product];
    }
  }

  bool isFavorite(int productId) {
    return state.any((item) => item.id == productId);
  }
}

// Global provider for accessing the wishlist
final wishlistProvider = StateNotifierProvider<WishlistNotifier, List<Product>>(
  (ref) {
    return WishlistNotifier();
  },
);
