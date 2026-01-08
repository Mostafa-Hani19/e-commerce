import 'package:ecommerce/core/constants/app_strings.dart';
import 'package:ecommerce/core/providers/cart_provider.dart';
import 'package:ecommerce/core/theme/app_theme.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce/core/providers/user_provider.dart';
import 'package:ecommerce/presentation/screens/auth/login_screen.dart';

class AddToCartBar extends ConsumerWidget {
  final Product product;
  final String selectedColor;
  final String selectedSize;

  const AddToCartBar({
    super.key,
    required this.product,
    required this.selectedColor,
    required this.selectedSize,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                final userState = ref.read(userProvider);
                if (userState.value?.isGuest ?? false) {
                  _showLoginDialog(context);
                  return;
                }
                ref
                    .read(cartProvider.notifier)
                    .addToCart(
                      product,
                      color: selectedColor,
                      size: selectedSize,
                    );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(AppStrings.addedToCartMsg),
                    duration: Duration(milliseconds: 800),
                    backgroundColor: AppTheme.orangeColor,
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: AppTheme.orangeColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                AppStrings.addToCart,
                style: TextStyle(
                  color: AppTheme.orangeColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                final userState = ref.read(userProvider);
                if (userState.value?.isGuest ?? false) {
                  _showLoginDialog(context);
                  return;
                }
                ref
                    .read(cartProvider.notifier)
                    .addToCart(
                      product,
                      color: selectedColor,
                      size: selectedSize,
                    );

                // Navigate to checkout or cart
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(AppStrings.addedToCartRedirectMsg),
                    duration: Duration(milliseconds: 1000),
                    backgroundColor: AppTheme.orangeColor,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.orangeColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                AppStrings.buyNow,
                style: TextStyle(
                  color: AppTheme.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Required'),
        content: const Text('You need to login to perform this action.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            child: const Text(
              'Login',
              style: TextStyle(color: AppTheme.orangeColor),
            ),
          ),
        ],
      ),
    );
  }
}
