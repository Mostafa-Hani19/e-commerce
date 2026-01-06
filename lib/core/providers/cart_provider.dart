import 'package:ecommerce/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItem {
  final Product product;
  int quantity;
  final String? selectedColor;
  final String? selectedSize;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.selectedColor,
    this.selectedSize,
  });

  double get totalPrice => product.price * quantity;
}

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(Product product, {String? color, String? size}) {
    // Check if product already exists in cart
    final existingIndex = state.indexWhere(
      (item) =>
          item.product.id == product.id &&
          item.selectedColor == color &&
          item.selectedSize == size,
    );

    if (existingIndex != -1) {
      // Increase quantity if exists
      final updatedCart = [...state];
      updatedCart[existingIndex].quantity++;
      state = updatedCart;
    } else {
      // Add new item
      state = [
        ...state,
        CartItem(product: product, selectedColor: color, selectedSize: size),
      ];
    }
  }

  void removeFromCart(int index) {
    state = [...state.sublist(0, index), ...state.sublist(index + 1)];
  }

  void updateQuantity(int index, int quantity) {
    if (quantity <= 0) {
      removeFromCart(index);
      return;
    }

    final updatedCart = [...state];
    updatedCart[index].quantity = quantity;
    state = updatedCart;
  }

  void clearCart() {
    state = [];
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
