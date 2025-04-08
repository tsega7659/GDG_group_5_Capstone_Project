import 'dart:convert';

import 'package:e_commerce/core/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool isLoading = false;
  String _searchQuery = "All";

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    print('Fetching products...');
  }

  Future<void> _fetchProducts() async {
    setState(() {
      isLoading = true;
    });

    try {
      print('#####################################3');
      final url = Uri.parse("https://fakestoreapi.com/products");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _products = data.map((json) => Product.fromJson(json)).toList();
          _filteredProducts = _products;
          // print(data);
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load products: ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error searching products: $e')));
    }
  }

  void _searchProducts(String query) {
    setState(() {
      _searchQuery = query.isEmpty ? "All" : query;
      _filteredProducts =
          _products.where((product) {
            final titleLower = product.title.toLowerCase();
            final descriptionLower = product.description?.toLowerCase() ?? '';
            final queryLower = query.toLowerCase();

            return titleLower.contains(queryLower) ||
                descriptionLower.contains(queryLower);
          }).toList();
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _searchProducts("");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, size: 35),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200],
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.search, size: 35),
                            onPressed: () {
                              if (_searchController.text.isNotEmpty) {
                                _searchProducts(_searchController.text);
                              }
                            },
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search Here',
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                              ),
                              onSubmitted: _searchProducts,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.cancel, size: 35),
                            onPressed: _clearSearch,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    'Results for "$_searchQuery"',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20),
                  child: Text(
                    ' ${_filteredProducts.length} Results Found',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6055DB),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemCount: _filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = _filteredProducts[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(product.image),
                                  fit: BoxFit.cover,
                                  onError:
                                      (exception, stackTrace) =>
                                          Icon(Icons.error, size: 50),
                                ),
                              ),
                            ),

                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.favorite_rounded,
                                    color:
                                        product.isFavorite
                                            ? Colors.red
                                            : Colors.white,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      product.isFavorite = !product.isFavorite;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            product.title.length > 20
                                ? '${product.title.substring(0, 20)}...'
                                : product.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF6055DB),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFF6055DB),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}