import 'package:ecommerce/core/constants/app_strings.dart';
import 'package:ecommerce/core/widgets/shimmer_loading.dart';
import 'package:ecommerce/core/providers/category_provider.dart';
import 'package:ecommerce/core/providers/paginated_products_provider.dart';

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
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          _HomeContent(), 
          WishlistScreen(),
          SearchScreen(),
          ProfileScreen(),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: HomeBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

class _HomeContent extends ConsumerStatefulWidget {
  const _HomeContent();

  @override
  ConsumerState<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends ConsumerState<_HomeContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(paginatedProductsProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final paginationState = ref.watch(paginatedProductsProvider);
    final categoriesAsync = ref.watch(categoriesProvider);

    return SafeArea(
      child: Column(
        children: [
          const HomeHeader(),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const PromoBanner(),
                  const SizedBox(height: 30),
                  _buildContent(paginationState, categoriesAsync),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    PaginationState<Product> paginationState,
    AsyncValue<List<String>> categoriesAsync,
  ) {
    // Initial loading state 
    if (paginationState.items.isEmpty && paginationState.isLoading) {
      return const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 20),
            ShimmerLoading.rectangular(height: 160, width: double.infinity),
            SizedBox(height: 30),
          ],
        ),
      );
    }

    // Category loading
    if (categoriesAsync.isLoading) {

    }

    if (paginationState.error != null && paginationState.items.isEmpty) {
      return Center(
        child: Text('${AppStrings.errorLoadingData}${paginationState.error}'),
      );
    }

    final products = paginationState.items;
    final categories = categoriesAsync.value ?? [];

    // Extract images
    final categoryImages = <String, String>{};
    for (var product in products) {
      if (!categoryImages.containsKey(product.category)) {
        categoryImages[product.category] = product.image;
      }
    }

    return Column(
      children: [
        if (categories.isNotEmpty)
          CategoriesSection(
            categories: categories,
            categoryImages: categoryImages,
          ),
        const SizedBox(height: 30),
        ProductsSection(products: products),
        if (paginationState.isLoading && products.isNotEmpty)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          ),
        if (!paginationState.hasMore && products.isNotEmpty)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'No more products',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        const SizedBox(height: 20),
      ],
    );
  }
}
