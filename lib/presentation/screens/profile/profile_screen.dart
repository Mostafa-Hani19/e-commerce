import 'package:ecommerce/core/constants/app_strings.dart';
import 'package:ecommerce/core/theme/app_theme.dart';
import 'package:ecommerce/presentation/screens/profile/widgets/profile_header.dart';
import 'package:ecommerce/presentation/screens/profile/widgets/profile_menu_list.dart';
import 'package:ecommerce/presentation/screens/profile/widgets/profile_stats_card.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                AppStrings.account,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.blackColor,
                ),
              ),
              const SizedBox(height: 24),

              // User Info
              const ProfileHeader(),
              const SizedBox(height: 24),

              // Stats Dashboard
              const ProfileStatsCard(),
              const SizedBox(height: 16),

              // Menu Items
              const ProfileMenuList(),
            ],
          ),
        ),
      ),
    );
  }
}
