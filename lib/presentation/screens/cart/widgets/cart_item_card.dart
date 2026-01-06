import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/widgets/shimmer_loading.dart';
import 'package:ecommerce/core/providers/cart_provider.dart';
import 'package:ecommerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final int index;
  final CartNotifier cartNotifier;

  const CartItemCard({
    super.key,
    required this.item,
    required this.index,
    required this.cartNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.white12 : AppTheme.greyColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              // Removed invalid image property in favor of child
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: item.product.image,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const ShimmerLoading.rectangular(height: double.infinity),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error_outline, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                if (item.selectedColor != null || item.selectedSize != null)
                  Text(
                    '${item.selectedColor ?? ''} ${item.selectedSize ?? ''}',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? Colors.grey[400]
                          : AppTheme.greyColor.withOpacity(0.8),
                    ),
                  ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.orangeColor,
                      ),
                    ),
                    // Quantity Controls
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isDark
                              ? Colors.white12
                              : AppTheme.greyColor.withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.remove,
                              size: 18,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onPressed: () {
                              cartNotifier.updateQuantity(
                                index,
                                item.quantity - 1,
                              );
                            },
                            padding: const EdgeInsets.all(4),
                            constraints: const BoxConstraints(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '${item.quantity}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add,
                              size: 18,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onPressed: () {
                              cartNotifier.updateQuantity(
                                index,
                                item.quantity + 1,
                              );
                            },
                            padding: const EdgeInsets.all(4),
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Delete Button
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppTheme.redColor),
            onPressed: () {
              cartNotifier.removeFromCart(index);
            },
          ),
        ],
      ),
    );
  }
}
