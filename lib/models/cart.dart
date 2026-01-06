class Cart {
  final int id;
  final int userId;
  final DateTime date;
  final List<CartProduct> products;

  const Cart({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      userId: json['userId'],
      date: DateTime.parse(json['date']),
      products: (json['products'] as List)
          .map((e) => CartProduct.fromJson(e))
          .toList(),
    );
  }
}

class CartProduct {
  final int productId;
  final int quantity;

  const CartProduct({required this.productId, required this.quantity});

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }
}
