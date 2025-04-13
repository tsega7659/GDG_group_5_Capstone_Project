import 'package:e_commerce/core/api/api_service.dart';
import 'package:e_commerce/features/product/presentation/filter_screen.dart';
import 'package:e_commerce/features/product/presentation/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_list_bloc.dart';
import '../../../core/models/product_model.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  Map<String, dynamic>? _activeFilters;

  void _openFilterScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FilterScreen()),
    );

    if (result != null && mounted) {
      setState(() {
        _activeFilters = result;
      });
      // Trigger product list refresh with new filters
      context.read<ProductListBloc>().add(LoadProductList());
    }
  }

  List<Product> _applyFilters(List<Product> products) {
    if (_activeFilters == null) return products;

    return products.where((product) {
      // Apply gender filter
      if (_activeFilters!['gender'] != 'All' &&
          !(product.category?.toLowerCase() ?? '').contains(
            _activeFilters!['gender'].toLowerCase(),
          )) {
        return false;
      }

      // Apply brand filter
      if (_activeFilters!['brands'].isNotEmpty &&
          !_activeFilters!['brands'].any(
            (brand) =>
                product.title.toLowerCase().contains(brand.toLowerCase()),
          )) {
        return false;
      }

      // Apply price filter
      final RangeValues priceRange = _activeFilters!['priceRange'];
      if (product.price < priceRange.start || product.price > priceRange.end) {
        return false;
      }

      // Apply color filter (assuming product has a color property or it's in the description)
      if (_activeFilters!['colors'].isNotEmpty) {
        bool hasMatchingColor = _activeFilters!['colors'].any(
          (color) =>
              (product.description?.toLowerCase() ?? '').contains(
                color.toLowerCase(),
              ) ||
              (product.title?.toLowerCase() ?? '').contains(
                color.toLowerCase(),
              ),
        );
        if (!hasMatchingColor) return false;
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              ProductListBloc(apiService: ApiService())..add(LoadProductList()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Products'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Stack(
                children: [
                  const Icon(Icons.filter_list),
                  if (_activeFilters != null)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 8,
                          minHeight: 8,
                        ),
                      ),
                    ),
                ],
              ),
              onPressed: _openFilterScreen,
            ),
          ],
        ),
        body: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            if (state is ProductListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductListError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is ProductListLoaded) {
              final filteredProducts = _applyFilters(state.products);

              if (filteredProducts.isEmpty) {
                return const Center(
                  child: Text(
                    'No products match the selected filters',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              return GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return ProductCard(
                    name:
                        product.title.length > 20
                            ? '${product.title.substring(0, 20)}...'
                            : product.title,
                    price: '\$${product.price}',
                    imageUrl: product.image,
                    product: product,
                  );
                },
              );
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final String name;
  final String price;
  final String imageUrl;
  final Product product;

  const ProductCard({
    Key? key,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  Future<void> _addToCart(Product product, BuildContext context) async {
    try {
      final apiService = ApiService();
      // First get existing carts for the user
      final cartItem = {
        "userId": 1, // Replace with actual user ID when you have authentication
        "date": DateTime.now().toIso8601String(),
        "products": [
          {"productId": product.id, "quantity": 1},
        ],
      };

      // Send POST request to add item to cart
      await apiService.post('carts', cartItem);

      // Show success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product.title} added to cart'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add item to cart: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: widget.product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.grey[200],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                    child: Image.network(widget.imageUrl, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    widget.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 4.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    widget.price,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 8.0,
              right: 8.0,
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.deepPurple : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
              ),
            ),
            Positioned(
              bottom: 8.0,
              right: 8.0,
              child: GestureDetector(
                onTap: () => _addToCart(widget.product, context),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
