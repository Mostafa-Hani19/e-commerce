import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/widgets/shimmer_loading.dart';
import 'package:ecommerce/core/providers/wishlist_provider.dart';
import 'package:ecommerce/core/theme/app_theme.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductImageCarousel extends ConsumerStatefulWidget {
  final Product product;

  const ProductImageCarousel({super.key, required this.product});

  @override
  ConsumerState<ProductImageCarousel> createState() =>
      _ProductImageCarouselState();
}

class _ProductImageCarouselState extends ConsumerState<ProductImageCarousel> {
  int _selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final wishlist = ref.watch(wishlistProvider);
    final isFavorite = wishlist.any((item) => item.id == widget.product.id);

    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: 3, // Simulate 3 images
            onPageChanged: (index) {
              setState(() {
                _selectedImageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: widget.product.image,
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        const ShimmerLoading.rectangular(
                          height: double.infinity,
                        ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error_outline, color: Colors.grey),
                  ),
                ),
              );
            },
          ),
          // Favorite Icon
          Positioned(
            right: 24,
            top: 16,
            child: GestureDetector(
              onTap: () {
                ref
                    .read(wishlistProvider.notifier)
                    .toggleWishlist(widget.product);
              },
              child: CircleAvatar(
                backgroundColor: AppTheme.whiteColor,
                radius: 20,
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                  size: 24,
                ),
              ),
            ),
          ),
          // Indicators
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _selectedImageIndex == index
                        ? AppTheme.blackColor
                        : Colors.grey.withOpacity(0.4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
