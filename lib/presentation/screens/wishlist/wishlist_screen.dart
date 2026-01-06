import 'package:ecommerce/core/constants/app_strings.dart';
import 'package:ecommerce/core/providers/wishlist_provider.dart';
import 'package:ecommerce/core/theme/app_theme.dart';
import 'package:ecommerce/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistProducts = ref.watch(wishlistProvider);

    return Scaffold(
      // backgroundColor: AppTheme.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                AppStrings.myWishlist,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.orangeColor,
                ),
              ),
            ),
            Expanded(
              child: wishlistProducts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 64,
                            color: AppTheme.greyColor.withOpacity(0.3),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            AppStrings.wishlistEmpty,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppTheme.greyColor.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                      itemCount: wishlistProducts.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: wishlistProducts[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
