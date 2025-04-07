import 'package:flutter/material.dart';
import 'package:your_app/core/theme/app_theme.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

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
            _buildOrderSummarySection(theme),
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

  Widget _buildOrderSummarySection(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: theme.dividerColor),
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
          _buildOrderRow('Items', '3'),
          _buildOrderRow('Subtotal', '\$423'),
          _buildOrderRow('Discount', '\$4'),
          _buildOrderRow('Delivery Charges', '\$2'),
          const Divider(height: 24),
          _buildOrderRow('Total', '\$423', isBold: true),
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

  Widget _buildPaymentMethodOption(String title, IconData icon,
      {bool isSelected = false}) {
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
            child: isSelected
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
          // Handle checkout
        },
        child: const Text(
          'Check Out',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
