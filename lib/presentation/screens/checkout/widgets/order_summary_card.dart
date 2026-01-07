import 'package:ecommerce/core/constants/app_strings.dart';
import 'package:ecommerce/core/providers/cart_provider.dart';
import 'package:ecommerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderSummaryCard extends ConsumerWidget {
  const OrderSummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Using granular providers to rebuild only when these specific values change
    final subtotal = ref.watch(cartSubtotalProvider);
    final shipping = ref.watch(cartShippingProvider);
    final tax = ref.watch(cartTaxProvider);
    final total = ref.watch(cartTotalProvider);
    // final isDark = Theme.of(context).brightness == Brightness.dark; // Not used currently

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.orderSummary,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 20),
          _buildSummaryRow(
            context,
            AppStrings.subtotal,
            '\$${subtotal.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(
            context,
            AppStrings.shipping,
            '\$${shipping.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(
            context,
            AppStrings.tax,
            '\$${tax.toStringAsFixed(2)}',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(),
          ),
          _buildSummaryRow(
            context,
            AppStrings.total,
            '\$${total.toStringAsFixed(2)}',
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
