import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/core/models/product_model.dart';
import 'package:e_commerce/features/product/presentation/product_list_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    // Updated sample product using the new Product model.
    final sampleProduct = Product(
      id: 1,
      title: 'Sample Nike Shoes',
      price: 430,
      description: 'This is a description of the Nike Shoes. It’s designed for comfort and style, perfect for everyday wear.',
      category: 'Shoes',
      image: 'https://example.com/nike_shoes.jpg',
    );

    return MaterialApp(
      title: 'Product App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ProductDetailScreen(product: sampleProduct),
    );
  }
}






class Product {
  final String name;
  final String imageUrl; 
  final double price;
  final double rating;
  final int reviewCount;
  final String description;
  final List<String> sizes;

  Product({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.sizes, required String title, required int id, required String category, required String image,
  });
}

// Product Detail Screen
class ProductDetailScreen extends StatefulWidget {
  final Product product; // Full product data passed to the screen

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late String selectedSize;

  @override
  void initState() {
    super.initState();
    selectedSize = widget.product.sizes.first; // Default to first size
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
           
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image (50% of width)
                Container(
                  width: constraints.maxWidth * 0.5,
                  child: Image.network(
                    widget.product.imageUrl, // Image loaded from API URL
                    fit: BoxFit.contain,
                  ),
                ),
                // Product Details (scrollable)
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: buildProductDetails(),
                  ),
                ),
              ],
            );
          } else {
            
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: Image.network(
                      widget.product.imageUrl, 
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: buildProductDetails(),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }


  Widget buildProductDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    
        Text(
          widget.product.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        
        Text(
          '\$${widget.product.price.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 20, color: Colors.green),
        ),
        
        Row(
          children: [
            const Icon(Icons.star, color: Colors.yellow),
            const SizedBox(width: 4),
            Text(
              '${widget.product.rating}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(width: 5),
            Text(
              '(${widget.product.reviewCount} Reviews)',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        Text(
          widget.product.description,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        
        const Text(
          'Size',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: widget.product.sizes.map((size) {
            return ChoiceChip(
              label: Text(size),
              selected: selectedSize == size,
              onSelected: (selected) {
                setState(() {
                  selectedSize = size;
                });
              },
              selectedColor: Colors.blue.withOpacity(0.2),
              backgroundColor: Colors.grey[200],
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckoutScreen(
                  product: widget.product,
                  size: selectedSize,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: const Text('Buy Now'),
        ),
      ],
    );
  }
}

class CheckoutScreen extends StatelessWidget {
  final Product product;
  final String size;

  const CheckoutScreen({super.key, required this.product, required this.size});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Center(
        child: Text('Checkout for ${product.name}, size $size'),
      ),
    );
  }
}