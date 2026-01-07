import 'dart:convert';
import 'package:ecommerce/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistNotifier extends StateNotifier<List<Product>> {
  static const String _wishlistKey = 'wishlist_items';

  WishlistNotifier() : super([]) {
    _loadWishlist();
  }

  Future<void> _loadWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final String? wishlistStr = prefs.getString(_wishlistKey);
    if (wishlistStr != null && wishlistStr.isNotEmpty) {
      try {
        final List<dynamic> decodedList = jsonDecode(wishlistStr);
        state = decodedList.map((item) => Product.fromJson(item)).toList();
      } catch (e) {
        // ignore error
      }
    }
  }

  Future<void> _saveWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedList = jsonEncode(
      state.map((item) => item.toJson()).toList(),
    );
    await prefs.setString(_wishlistKey, encodedList);
  }

  void toggleWishlist(Product product) {
    if (state.where((p) => p.id == product.id).isNotEmpty) {
      state = state.where((p) => p.id != product.id).toList();
    } else {
      state = [...state, product];
    }
    _saveWishlist();
  }

  bool isInWishlist(Product product) {
    return state.any((p) => p.id == product.id);
  }
}

final wishlistProvider = StateNotifierProvider<WishlistNotifier, List<Product>>(
  (ref) {
    return WishlistNotifier();
  },
);
