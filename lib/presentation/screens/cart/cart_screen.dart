import 'package:ecommerce/core/providers/cart_provider.dart';
import 'package:ecommerce/core/theme/app_theme.dart';
import 'package:ecommerce/core/constants/app_strings.dart';
import 'package:ecommerce/presentation/screens/cart/widgets/cart_checkout_bar.dart';
import 'package:ecommerce/presentation/screens/cart/widgets/cart_item_card.dart';
import 'package:ecommerce/presentation/screens/cart/widgets/empty_cart_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: AppBar(
        backgroundColor: AppTheme.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.blackColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          AppStrings.shoppingCart,
          style: TextStyle(
            color: AppTheme.blackColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.shopping_cart, color: AppTheme.orangeColor),
          ),
        ],
      ),
      body: cart.isEmpty
          ? const EmptyCartView()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      return CartItemCard(
                        item: item,
                        index: index,
                        cartNotifier: cartNotifier,
                      );
                    },
                  ),
                ),
                CartCheckoutBar(cartNotifier: cartNotifier),
              ],
            ),
    );
  }
}
