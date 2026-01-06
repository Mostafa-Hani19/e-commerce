import 'package:ecommerce/core/constants/app_strings.dart';
import 'package:ecommerce/core/providers/cart_provider.dart';
import 'package:ecommerce/core/theme/app_theme.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        color: AppTheme.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppTheme.blackColor.withOpacity(0.05),
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
                ref
                    .read(cartProvider.notifier)
                    .addToCart(
                      product,
                      color: selectedColor,
                      size: selectedSize,
                    );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Added to cart!'),
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
                    content: Text('Added to cart! Redirecting to checkout...'),
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
}
