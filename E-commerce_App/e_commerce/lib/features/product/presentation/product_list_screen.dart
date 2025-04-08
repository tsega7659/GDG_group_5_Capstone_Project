import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Products'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: _products.length, // Placeholder data
        itemBuilder: (context, index) {
          final product = _products[index];
          return ProductCard(
            name: product['name']!,
            price: product['price']!,
            imageUrl: product['imageUrl']!,
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
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
                child: Text(
                  price,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          Positioned(
            top: 8.0,
            right: 8.0,
            child: IconButton(
              icon: const Icon(Icons.favorite_border, color: Colors.white),
              onPressed: () {
                // TODO: Implement favorite action
              },
            ),
          ),
          Positioned(
            bottom: 8.0,
            right: 8.0,
            child: InkWell(
              onTap: () {
                // TODO: Implement add to cart action
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.deepPurple, // Or your theme color
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder product data
final List<Map<String, String>> _products = [
  {'name': 'Watch', 'price': '\$40', 'imageUrl': 'https://picsum.photos/200/200'},
  {'name': 'Nike Shoes', 'price': '\$430', 'imageUrl': 'https://picsum.photos/201/200'},
  {'name': 'Airpods', 'price': '\$333', 'imageUrl': 'https://picsum.photos/202/200'},
  {'name': 'LG TV', 'price': '\$330', 'imageUrl': 'https://picsum.photos/203/200'},
  {'name': 'Hoodie', 'price': '\$50', 'imageUrl': 'https://picsum.photos/204/200'},
  {'name': 'Jacket', 'price': '\$400', 'imageUrl': 'https://picsum.photos/205/200'},
];