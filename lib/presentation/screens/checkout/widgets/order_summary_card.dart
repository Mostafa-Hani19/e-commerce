import 'package:ecommerce/core/constants/app_strings.dart';
import 'package:ecommerce/core/providers/cart_provider.dart';
import 'package:ecommerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderSummaryCard extends ConsumerWidget {
  const OrderSummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cart = ref.watch(cartProvider.notifier);

    // We watch the list to rebuild, but access calculations from notifier
    ref.watch(cartProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : AppTheme.greyColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildSummaryRow(
            context,
            AppStrings.subtotal,
            '\$${cart.subtotal.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(
            context,
            AppStrings.shipping,
            '\$${cart.shipping.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(
            context,
            AppStrings.tax,
            '\$${cart.tax.toStringAsFixed(2)}',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(
              height: 1,
              color: isDark
                  ? Colors.white24
                  : AppTheme.greyColor.withOpacity(0.5),
            ),
          ),
          _buildSummaryRow(
            context,
            AppStrings.total,
            '\$${cart.total.toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String label,
    String value, {
    bool isTotal = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal
                ? Theme.of(context).textTheme.titleLarge?.color
                : (isDark ? Colors.grey[400] : AppTheme.greyColor),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: FontWeight.bold,
            color: isTotal
                ? AppTheme.orangeColor
                : Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
      ],
    );
  }
}
