import 'dart:convert';
import 'package:ecommerce/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartItem {
  final Product product;
  final int quantity;
  final String? selectedColor;
  final String? selectedSize;

  const CartItem({
    required this.product,
    this.quantity = 1,
    this.selectedColor,
    this.selectedSize,
  });

  double get totalPrice => product.price * quantity;

  CartItem copyWith({
    Product? product,
    int? quantity,
    String? selectedColor,
    String? selectedSize,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
      'selectedColor': selectedColor,
      'selectedSize': selectedSize,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
      selectedColor: json['selectedColor'],
      selectedSize: json['selectedSize'],
    );
  }
}

class CartNotifier extends StateNotifier<List<CartItem>> {
  static const String _cartKey = 'cart_items';

  CartNotifier() : super([]) {
    _loadCart();
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartString = prefs.getString(_cartKey);
    if (cartString != null && cartString.isNotEmpty) {
      try {
        final List<dynamic> decodedList = jsonDecode(cartString);
        state = decodedList.map((item) => CartItem.fromJson(item)).toList();
      } catch (e) {
        // Handle error or ignore
      }
    }
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedList = jsonEncode(
      state.map((item) => item.toJson()).toList(),
    );
    await prefs.setString(_cartKey, encodedList);
  }

  void addToCart(Product product, {String? color, String? size}) {
    // Check if product already exists in cart
    final existingIndex = state.indexWhere(
      (item) =>
          item.product.id == product.id &&
          item.selectedColor == color &&
          item.selectedSize == size,
    );

    if (existingIndex != -1) {
      // Increase quantity if exists (Using copyWith for immutability)
      final updatedCart = [...state];
      final existingItem = updatedCart[existingIndex];
      updatedCart[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + 1,
      );
      state = updatedCart;
    } else {
      // Add new item
      state = [
        ...state,
        CartItem(product: product, selectedColor: color, selectedSize: size),
      ];
    }
    _saveCart();
  }

  void removeFromCart(int index) {
    state = [...state.sublist(0, index), ...state.sublist(index + 1)];
    _saveCart();
  }

  void updateQuantity(int index, int quantity) {
    if (quantity <= 0) {
      removeFromCart(index);
      return;
    }

    final updatedCart = [...state];
    updatedCart[index] = updatedCart[index].copyWith(quantity: quantity);
    state = updatedCart;
    _saveCart();
  }

  void clearCart() {
    state = [];
    _saveCart();
  }

  double get subtotal {
    return state.fold(0, (sum, item) => sum + item.totalPrice);
  }

  double get shipping => 10.0;
  double get tax => subtotal * 0.05; // 5% tax
  double get total => subtotal + shipping + tax;

  int get itemCount {
    return state.fold(0, (sum, item) => sum + item.quantity);
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

// Derived Providers (State Splitting)
final cartCountProvider = Provider<int>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0, (sum, item) => sum + item.quantity);
});

final cartSubtotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0, (sum, item) => sum + item.totalPrice);
});

final cartTaxProvider = Provider<double>((ref) {
  final subtotal = ref.watch(cartSubtotalProvider);
  return subtotal * 0.05;
});

final cartShippingProvider = Provider<double>((ref) {
  return 10.0; // Fixed shipping for now
});

final cartTotalProvider = Provider<double>((ref) {
  final subtotal = ref.watch(cartSubtotalProvider);
  final tax = ref.watch(cartTaxProvider);
  final shipping = ref.watch(cartShippingProvider);
  return subtotal + tax + shipping;
});
