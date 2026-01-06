import 'package:ecommerce/core/constants/app_strings.dart';
import 'package:ecommerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ProfileMenuList extends StatelessWidget {
  const ProfileMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMenuItem(AppStrings.accountDetails, Icons.person_outline),
        _buildMenuItem(AppStrings.loyaltyCards, Icons.card_membership),
        _buildMenuItem(AppStrings.notifications, Icons.notifications_outlined),
        _buildMenuItem(AppStrings.deliveryInfo, Icons.local_shipping_outlined),
        _buildMenuItem(AppStrings.paymentInfo, Icons.payment_outlined),
        _buildMenuItem(AppStrings.language, Icons.language),
        _buildMenuItem(AppStrings.privacySettings, Icons.privacy_tip_outlined),
        const SizedBox(height: 20),
        _buildMenuItem(AppStrings.logout, Icons.logout, isLogout: true),
      ],
    );
  }

  Widget _buildMenuItem(String title, IconData icon, {bool isLogout = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isLogout
              ? AppTheme.redColor.withOpacity(0.3)
              : AppTheme.greyColor.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: isLogout
                ? AppTheme.redColor.withOpacity(0.05)
                : AppTheme.greyColor.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isLogout
                ? AppTheme.redColor.withOpacity(0.1)
                : AppTheme.orangeColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isLogout ? AppTheme.redColor : AppTheme.orangeColor,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isLogout ? AppTheme.redColor : AppTheme.blackColor,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: isLogout
              ? AppTheme.redColor.withOpacity(0.5)
              : AppTheme.greyColor.withOpacity(0.5),
        ),
        onTap: () {
          if (isLogout) {
            // TODO: Implement Logout Logic
          }
        },
      ),
    );
  }
}
