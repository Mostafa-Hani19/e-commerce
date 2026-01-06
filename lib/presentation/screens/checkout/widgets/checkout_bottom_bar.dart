import 'package:ecommerce/core/constants/app_strings.dart';
import 'package:ecommerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CheckoutBottomBar extends StatelessWidget {
  final VoidCallback onCompleteOrder;

  const CheckoutBottomBar({super.key, required this.onCompleteOrder});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : AppTheme.blackColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onCompleteOrder,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.orangeColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              AppStrings.completeOrder,
              style: TextStyle(
                color: AppTheme.whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
