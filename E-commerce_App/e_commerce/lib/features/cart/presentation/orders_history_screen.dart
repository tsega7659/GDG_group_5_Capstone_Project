import 'package:flutter/material.dart';
import '../../../core/models/product_model.dart';

class OrdersHistoryScreen extends StatelessWidget {
  final List<Product> orders;

  const OrdersHistoryScreen({Key? key, required this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order History'), centerTitle: true),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final product = orders[index];
          return ListTile(
            leading: Image.network(product.image, width: 50, height: 50),
            title: Text(product.title),
            subtitle: Text('\$${product.price}'),
          );
        },
      ),
    );
  }
}

Widget _buildOrderList(List<Widget> orders) {
  return ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: orders.length,
    itemBuilder:
        (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: orders[index],
        ),
  );
}

Widget _buildOrderCard({
  required String image,
  required String title,
  required String brand,
  required String price,
}) {
  return Card(
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(image, width: 60, height: 60, fit: BoxFit.cover),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(brand),
                    const SizedBox(height: 4),
                    Text(
                      price,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                // Handle track order
              },
              child: const Text('Track Order'),
            ),
          ),
        ],
      ),
    ),
  );
}
