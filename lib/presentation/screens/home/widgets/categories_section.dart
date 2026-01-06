import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/widgets/shimmer_loading.dart';
import 'package:ecommerce/presentation/screens/home/category_products_screen.dart';
import 'package:ecommerce/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class CategoriesSection extends StatelessWidget {
  final List<String> categories;
  final Map<String, String> categoryImages;

  const CategoriesSection({
    super.key,
    required this.categories,
    required this.categoryImages,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.categories,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor,
                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                ),
                child: const Text(AppStrings.seeAll),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 140, // Increased height for better proportions
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Padding(
                padding: const EdgeInsets.only(
                  right: 4,
                ), // Spacing handled in card
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryProductsScreen(categoryName: category),
                      ),
                    );
                  },
                  child: _buildCategoryCard(
                    context,
                    // Capitalize first letter
                    category.substring(0, 1).toUpperCase() +
                        category.substring(1),
                    categoryImages[category],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String title,
    String? imageUrl,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isDark ? const Color(0xff2A2A2A) : const Color(0xffF5F5F5),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withOpacity(0.3)
                      : Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: imageUrl != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.contain,
                        placeholder: (context, url) =>
                            const ShimmerLoading.rectangular(
                              height: double.infinity,
                            ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.category_outlined,
                          color: isDark ? Colors.grey[600] : Colors.grey[400],
                          size: 30,
                        ),
                      ),
                    )
                  : Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: isDark ? Colors.grey[600] : Colors.grey[400],
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.grey[300] : Colors.grey[800],
                letterSpacing: 0.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
