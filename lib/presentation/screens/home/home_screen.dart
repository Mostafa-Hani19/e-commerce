import 'package:ecommerce/core/network/api_service.dart';

import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/presentation/screens/home/widgets/categories_section.dart';
import 'package:ecommerce/presentation/screens/home/widgets/home_bottom_nav_bar.dart';
import 'package:ecommerce/presentation/screens/home/widgets/home_header.dart';
import 'package:ecommerce/presentation/screens/home/widgets/products_section.dart';
import 'package:ecommerce/presentation/screens/home/widgets/promo_banner.dart';
import 'package:ecommerce/presentation/screens/profile/profile_screen.dart';
import 'package:ecommerce/presentation/screens/search/search_screen.dart';
import 'package:ecommerce/presentation/screens/wishlist/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ApiService _apiService = ApiService();
  List<Product> _products = [];
  List<String> _categories = [];
  bool _isLoading = true;
  int _selectedIndex = 0;
  Map<String, String> _categoryImages = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final futures = await Future.wait([
        _apiService.getProducts(),
        _apiService.getCategories(),
      ]);

      if (mounted) {
        final products = futures[0] as List<Product>;
        final categories = futures[1] as List<String>;

        // Extract images for each category from products
        final categoryImages = <String, String>{};
        for (var product in products) {
          if (!categoryImages.containsKey(product.category)) {
            categoryImages[product.category] = product.image;
          }
        }

        setState(() {
          _products = products;
          _categories = categories;
          _categoryImages = categoryImages;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error loading data: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppTheme.whiteColor,
      body: _getBody(),
      extendBody: true,
      bottomNavigationBar: HomeBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }

  Widget _getBody() {
    switch (_selectedIndex) {
      case 1:
        return const WishlistScreen();
      case 2:
        return const SearchScreen();
      case 3:
        return const ProfileScreen();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    return SafeArea(
      child: Column(
        children: [
          const HomeHeader(),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const PromoBanner(),
                        const SizedBox(height: 30),
                        CategoriesSection(
                          categories: _categories,
                          categoryImages: _categoryImages,
                        ),
                        const SizedBox(height: 30),
                        ProductsSection(products: _products),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
