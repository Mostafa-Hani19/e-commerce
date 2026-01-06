import 'package:ecommerce/core/constants/app_strings.dart';
import 'package:ecommerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PaymentMethodSelector extends StatelessWidget {
  final int selectedMethod;
  final Function(int) onMethodSelected;

  const PaymentMethodSelector({
    super.key,
    required this.selectedMethod,
    required this.onMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPaymentMethod(AppStrings.creditCard, Icons.credit_card, 0),
        const SizedBox(height: 12),
        _buildPaymentMethod(AppStrings.payPal, Icons.paypal, 1),
        const SizedBox(height: 12),
        _buildPaymentMethod(AppStrings.cashOnDelivery, Icons.money, 2),
      ],
    );
  }

  Widget _buildPaymentMethod(String title, IconData icon, int index) {
    final isSelected = selectedMethod == index;
    return GestureDetector(
      onTap: () => onMethodSelected(index),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppTheme.orangeColor
                : AppTheme.greyColor.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.orangeColor.withOpacity(0.1)
                    : AppTheme.greyColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? AppTheme.orangeColor
                    : AppTheme.greyColor.withOpacity(0.8),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? AppTheme.blackColor : AppTheme.greyColor,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppTheme.orangeColor,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
