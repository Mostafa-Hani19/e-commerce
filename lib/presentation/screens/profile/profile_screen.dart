import 'package:ecommerce/core/constants/app_strings.dart';

import 'package:ecommerce/presentation/screens/profile/widgets/profile_header.dart';
import 'package:ecommerce/presentation/screens/profile/widgets/profile_menu_list.dart';
import 'package:ecommerce/presentation/screens/profile/widgets/profile_stats_card.dart';
import 'package:ecommerce/presentation/screens/auth/login_screen.dart';
import 'package:ecommerce/core/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final userState = ref.watch(userProvider);
        final isGuest = userState.value?.isGuest ?? false;

        return Scaffold(
          // backgroundColor: AppTheme.whiteColor,
          body: SafeArea(
            child: isGuest
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.person_outline,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Guest User',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        const Text('Please login to view your profile'),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFA6E21),
                          ),
                          child: const Text(
                            'Login Now',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        const Text(
                          AppStrings.account,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            // color: AppTheme.blackColor,
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
      },
    );
  }
}
