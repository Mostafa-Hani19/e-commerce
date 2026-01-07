import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/core/providers/theme_provider.dart';
import 'package:ecommerce/core/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Row(
      children: [
        Stack(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.orangeColor, width: 2),
                image: const DecorationImage(
                  image: CachedNetworkImageProvider(
                    "https://cdn-icons-png.flaticon.com/512/9308/9308269.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppTheme.orangeColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 14,
                  color: AppTheme.whiteColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Consumer(
            builder: (context, ref, child) {
              final userAsync = ref.watch(userProvider);
              return userAsync.when(
                data: (user) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.name.firstname} ${user.name.lastname}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.email_outlined,
                          size: 16,
                          color: AppTheme.greyColor.withOpacity(0.8),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          user.email,
                          style: TextStyle(
                            color: AppTheme.greyColor.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                loading: () => const Text('Loading...'),
                error: (err, stack) => Text('Error: $err'),
              );
            },
          ),
        ),
        // Theme Toggle Button
        IconButton(
          onPressed: () {
            ref.read(themeProvider.notifier).toggleTheme();
          },
          icon: Icon(
            isDark ? Icons.light_mode : Icons.dark_mode,
            color: AppTheme.orangeColor,
          ),
        ),
      ],
    );
  }
}
