import 'package:ecommerce/core/constants/app_images.dart';
import 'package:ecommerce/core/constants/app_strings.dart';
import 'package:ecommerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.orangeColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppStrings.discount50,
                  style: TextStyle(
                    color: AppTheme.whiteColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  AppStrings.withCode,
                  style: TextStyle(color: AppTheme.whiteColor, fontSize: 16),
                ),
                const SizedBox(height: 12),
                Text(
                  AppStrings.shopNow,
                  style: const TextStyle(
                    color: AppTheme.blackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            AppImages.logo,
            width: 100,
            height: 100,
            color: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
