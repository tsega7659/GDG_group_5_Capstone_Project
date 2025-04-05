import 'package:flutter/material.dart';

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
      backgroundColor: Color(0xFFF4F3F6),
      appBar: AppBar(
        backgroundColor:  Color(0xFFF4F3F6),
        elevation: 0,
        title: const Text(
          'Cart',
        ),
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
              onPressed: () {},
              child: const Text(
                'Check Out',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({Key? key, required this.cartItem}) : super(key: key);

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                image: NetworkImage(cartItem.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  cartItem.brand,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '\$${cartItem.price}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF766893),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.remove, color: Color(0xFF766893)),
                            onPressed: () {},
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '02', // Quantity
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF766893),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add, color: Color(0xFF766893)),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    Key? key,
    required this.totalItems,
    required this.subtotal,
    required this.discount,
    required this.deliveryCharges,
    required this.total,
  }) : super(key: key);

  final int totalItems;
  final double subtotal;
  final double discount;
  final double deliveryCharges;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        color: Color(0xFFF4F3F6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Items',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                totalItems.toString(),
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Subtotal',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '\$${subtotal.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Discount',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '\$${discount.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Delivery Charges',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '\$${deliveryCharges.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          const Divider(thickness: 1.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
