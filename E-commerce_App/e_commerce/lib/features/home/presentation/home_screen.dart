import 'dart:convert';
import 'package:e_commerce/features/product/presentation/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _products = []; // All products
  List<dynamic> _filteredProducts = []; // Filtered products for search
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    setState(() {
      isLoading = true;
    });

    try {
      final url = Uri.parse("https://fakestoreapi.com/products");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _products = data;
          _filteredProducts = _products; // Initially show all products
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  void _searchProducts(String query) {
    final searchResults =
        _products
            .where(
              (product) =>
                  product['title'].toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ProductListScreen(
              products: searchResults.cast<Map<String, dynamic>>(),
            ),
      ),
    );
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                    'assets/images/profile_1.jpeg',
                  ), // Placeholder image
                ),
                const SizedBox(width: 12.0),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hello!',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    Text(
                      'John William',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    // TODO: Implement notification action
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // App Bar Section (Profile, Greeting, Notification)
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Row(
                children: [
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
                                _searchProducts(
                                  _searchController.text,
                                ); // Navigate to ProductListScreen
                              }
                            },
                          ),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search Here',
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                              ),
                              onSubmitted:
                                  _searchProducts, // Optional: Trigger search on "Enter"
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.cancel, size: 35),
                            onPressed: _clearSearch, // Clear the input text
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Banner Carousel Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                height: 200.0,
                child: PageView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Color(0xFF6055DB),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Get Winter Discount',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  const Text(
                                    '20% Off',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  const Text(
                                    'For Children',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset('assets/images/home_screen.png'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Featured Products Section
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Featured',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: Implement see all action
                        },
                        child: const Text(
                          'See All',
                          style: TextStyle(color: Color(0xFF6055DB)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    height: 250.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children:
                          _products.map((product) {
                            return _buildProductCard(
                              product['title'].length > 20
                                  ? '${product['title'].substring(0, 20)}...'
                                  : product['title'], // Access the title using the map key
                              '\$${product['price']}', // Access the price using the map key
                              product['image'], // Access the image using the map key
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            // Most Popular Products Section
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Most Popular',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: Implement see all action
                        },
                        child: const Text(
                          'See All',
                          style: TextStyle(color: Color(0xFF6055DB)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    height: 250.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children:
                          _products.map((product) {
                            return _buildProductCard(
                              product['title'], // Access the title using the map key
                              '\$${product['price']}', // Access the price using the map key
                              product['image'], // Access the image using the map key
                            );
                          }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(String name, String price, String imageUrl) {
    return Container(
      width: 180.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
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
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                  child: Image.network(imageUrl, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 4.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(price, style: const TextStyle(color: Colors.grey)),
              ),
            ],
          ),
          const Positioned(
            top: 8.0,
            right: 8.0,
            child: Icon(Icons.favorite_border, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
