import 'package:ecommerce/core/theme/app_theme.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';

class ProductInfoSection extends StatelessWidget {
  final Product product;

  const ProductInfoSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.grey[400] : Colors.grey[600];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Brand & Rating
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              product.category.toUpperCase(),
              style: TextStyle(
                fontSize: 16,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                const Icon(Icons.star, color: AppTheme.orangeColor, size: 20),
                const SizedBox(width: 4),
                Text(
                  '(${product.rating.count})',
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Title
        Text(
          product.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            height: 1.2,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        const SizedBox(height: 12),

        // Price
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${product.price}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '\$${(product.price * 1.2).toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Description
        Text(
          product.description,
          style: TextStyle(fontSize: 14, color: textColor, height: 1.5),
        ),
      ],
    );
  }
}
