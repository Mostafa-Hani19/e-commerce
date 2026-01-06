import 'package:ecommerce/core/constants/app_strings.dart';
import 'package:ecommerce/core/theme/app_theme.dart';
import 'package:ecommerce/presentation/screens/checkout/widgets/address_card.dart';
import 'package:ecommerce/presentation/screens/checkout/widgets/checkout_bottom_bar.dart';
import 'package:ecommerce/presentation/screens/checkout/widgets/order_summary_card.dart';
import 'package:ecommerce/presentation/screens/checkout/widgets/payment_method_selector.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedPaymentMethod = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: AppBar(
        title: const Text(
          AppStrings.checkout,
          style: TextStyle(
            color: AppTheme.blackColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppTheme.blackColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Shipping Address Section
                  _buildSectionTitle(AppStrings.shippingAddress),
                  const SizedBox(height: 12),
                  const AddressCard(),
                  const SizedBox(height: 24),

                  // Payment Method Section
                  _buildSectionTitle(AppStrings.paymentMethod),
                  const SizedBox(height: 12),
                  PaymentMethodSelector(
                    selectedMethod: _selectedPaymentMethod,
                    onMethodSelected: (index) =>
                        setState(() => _selectedPaymentMethod = index),
                  ),
                  const SizedBox(height: 24),

                  // Order Summary Section
                  _buildSectionTitle(AppStrings.orderSummary),
                  const SizedBox(height: 12),
                  const OrderSummaryCard(),
                ],
              ),
            ),
          ),

          // Bottom Total and Button
          CheckoutBottomBar(onCompleteOrder: _showOrderSuccessDialog),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppTheme.blackColor,
      ),
    );
  }

  void _showOrderSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.orangeColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: AppTheme.orangeColor,
                size: 60,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              AppStrings.orderPlaced,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.blackColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              AppStrings.orderPlacedSuccess,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.greyColor.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Go back to previous screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.orangeColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  AppStrings.continueShopping,
                  style: TextStyle(
                    color: AppTheme.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
