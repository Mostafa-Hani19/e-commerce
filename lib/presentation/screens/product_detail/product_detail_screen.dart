import 'package:ecommerce/core/constants/app_strings.dart';
import 'package:ecommerce/core/providers/wishlist_provider.dart';

import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/add_to_cart_bar.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/color_size_selector.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/product_image_carousel.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/product_info_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  String _selectedColor = 'Black';
  String _selectedSize = 'M';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppTheme.whiteColor,
      appBar: AppBar(
        title: const Text(AppStrings.detailProduct),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).iconTheme.color,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final wishlist = ref.watch(wishlistProvider);
              final isInWishlist = wishlist.any(
                (item) => item.id == widget.product.id,
              );
              return IconButton(
                icon: Icon(
                  isInWishlist ? Icons.favorite : Icons.favorite_border,
                  color: isInWishlist
                      ? Colors.red
                      : Theme.of(context).iconTheme.color,
                ),
                onPressed: () {
                  ref
                      .read(wishlistProvider.notifier)
                      .toggleWishlist(widget.product);
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Carousel
                  ProductImageCarousel(product: widget.product),

                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Info
                        ProductInfoSection(product: widget.product),
                        const SizedBox(height: 24),

                        // Color & Size Selectors
                        ColorSizeSelector(
                          onColorChanged: (color) {
                            setState(() => _selectedColor = color);
                          },
                          onSizeChanged: (size) {
                            setState(() => _selectedSize = size);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Add to Cart Bar
          AddToCartBar(
            product: widget.product,
            selectedColor: _selectedColor,
            selectedSize: _selectedSize,
          ),
        ],
      ),
    );
  }
}
