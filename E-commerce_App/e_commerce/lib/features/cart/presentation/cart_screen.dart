import 'package:flutter/material.dart';
// Uncomment the one that applies for your navigation approach
// import 'package:auto_route/auto_route.dart';
// import 'package:your_app/routes/app_router.gr.dart';
 import 'checkout_screen.dart'; // If using basic navigation

class CartItemModel {
  final String name;
  final String brand;
  final double price;
  final String imageUrl;

  CartItemModel({
    required this.name,
    required this.brand,
    required this.price,
    required this.imageUrl,
  });
}

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  final List<CartItemModel> cartItems = [
    CartItemModel(
      name: 'Watch',
      brand: 'Rolex',
      price: 40,
      imageUrl: 'https://i.imgur.com/824kxAo.jpg',
    ),
    CartItemModel(
      name: 'Airpods',
      brand: 'Apple',
      price: 333,
      imageUrl: 'https://i.imgur.com/824kxAo.jpg',
    ),
    CartItemModel(
      name: 'Hoodie',
      brand: 'Puma',
      price: 50,
      imageUrl: 'https://i.imgur.com/824kxAo.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    int totalItems = cartItems.length;
    double subtotal = cartItems.fold(0, (sum, item) => sum + item.price);
    double discount = 4;
    double deliveryCharges = 2;
    double total = subtotal - discount + deliveryCharges;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F3F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F3F6),
        elevation: 0,
        title: const Text('Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF4F3F6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: ListView.builder(
                itemCount: cartItems.length,
                padding: const EdgeInsets.only(top: 20.0),
                itemBuilder: (context, index) {
                  return CartItem(cartItem: cartItems[index]);
                },
              ),
            ),
          ),
          OrderSummary(
            totalItems: totalItems,
            subtotal: subtotal,
            discount: discount,
            deliveryCharges: deliveryCharges,
            total: total,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF766893),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () {
                // Uncomment one of the options based on your setup

                // Option 1: auto_route
                // context.router.push(const CheckoutRoute());

                // Option 2: basic Navigator
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => const CheckoutScreen()));
              },
              child: const Text(
                'Proceed to Checkout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
