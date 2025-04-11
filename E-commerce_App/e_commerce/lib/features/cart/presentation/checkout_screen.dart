import 'package:flutter/material.dart';
import '../../../core/models/product_model.dart';
import 'orders_history_screen.dart';

class CheckoutScreen extends StatelessWidget {
  final List<Product> cartProducts;

  const CheckoutScreen({super.key, required this.cartProducts});

  @override
  Widget build(BuildContext context) {
    double subtotal = cartProducts.fold(0, (sum, item) => sum + item.price);
    double discount = 4;
    double deliveryCharges = 2;
    double total = subtotal - discount + deliveryCharges;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Check Out'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDeliveryInfoSection(),
            const SizedBox(height: 24),
            _buildOrderSummarySection(
              subtotal,
              discount,
              deliveryCharges,
              total,
            ),
            const SizedBox(height: 24),
            _buildPaymentMethodsSection(),
            const SizedBox(height: 24),
            _buildCheckoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.location_on, size: 24),
            const SizedBox(width: 8),
            const Text(
              '325 15th Eighth Avenue, NewYork',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(left: 32),
          child: Text('Saepe eaque fugiat ea voluptatum veniam.'),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.access_time, size: 24),
            const SizedBox(width: 8),
            const Text('6:00 pm, Wednesday 20'),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderSummarySection(
    double subtotal,
    double discount,
    double deliveryCharges,
    double total,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Order Summary',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          const SizedBox(height: 16),
          _buildOrderRow('Items', cartProducts.length.toString()),
          _buildOrderRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
          _buildOrderRow('Discount', '\$${discount.toStringAsFixed(2)}'),
          _buildOrderRow(
            'Delivery Charges',
            '\$${deliveryCharges.toStringAsFixed(2)}',
          ),
          const Divider(height: 24),
          _buildOrderRow(
            'Total',
            '\$${total.toStringAsFixed(2)}',
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose a payment method',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 16),
        _buildPaymentMethodOption('PayPal', Icons.payment, isSelected: true),
        _buildPaymentMethodOption('Credit Card', Icons.credit_card),
        _buildPaymentMethodOption('Apple Pay', Icons.apple),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey),
              ),
              child: const Icon(Icons.add, size: 16),
            ),
            const SizedBox(width: 8),
            const Text('Add a new payment method'),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentMethodOption(
    String title,
    IconData icon, {
    bool isSelected = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 8),
          Text(title),
          const Spacer(),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
              color: isSelected ? Colors.blue : null,
            ),
            child:
                isSelected
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : null,
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrdersHistoryScreen(orders: cartProducts),
            ),
          );
        },
        child: const Text(
          'Check Out',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
