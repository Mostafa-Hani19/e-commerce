import 'package:ecommerce/core/providers/cart_provider.dart';
import 'package:ecommerce/core/theme/app_theme.dart';
import 'package:ecommerce/core/constants/app_strings.dart';
import 'package:ecommerce/presentation/screens/cart/widgets/cart_checkout_bar.dart';
import 'package:ecommerce/presentation/screens/cart/widgets/cart_item_card.dart';
import 'package:ecommerce/presentation/screens/cart/widgets/empty_cart_view.dart';
import 'package:ecommerce/presentation/screens/auth/login_screen.dart';
import 'package:ecommerce/core/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final userState = ref.watch(userProvider);
    final isGuest = userState.value?.isGuest ?? false;

    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      // backgroundColor: AppTheme.whiteColor,
      appBar: AppBar(
        // backgroundColor: AppTheme.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppStrings.shoppingCart,
          style: TextStyle(
            color: Theme.of(context).textTheme.titleLarge?.color,
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
      body: isGuest
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_outline, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'Login Required',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text('Please login to view your cart'),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFA6E21),
                    ),
                    child: const Text(
                      'Login Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          : cart.isEmpty
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
                          )
                          .animate()
                          .slideX(
                            begin: 1,
                            duration: 300.ms,
                            delay: (100 * index).ms,
                          )
                          .fadeIn(duration: 300.ms);
                    },
                  ),
                ),
                CartCheckoutBar(),
              ],
            ),
    );
  }
}
