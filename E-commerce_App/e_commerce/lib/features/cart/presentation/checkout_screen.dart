import 'package:flutter/material.dart';
import '../../../core/models/product_model.dart';
import 'orders_history_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Product> cartProducts;
  final Map<int, int> quantities;

  const CheckoutScreen({
    Key? key,
    required this.cartProducts,
    required this.quantities,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPaymentMethod = 'PayPal';
  bool isDeliveryAddressExpanded = false;
  bool isDeliveryTimeExpanded = false;

  @override
  Widget build(BuildContext context) {
    double subtotal = widget.cartProducts.fold(0, (sum, product) {
      final quantity = widget.quantities[product.id] ?? 1;
      return sum + (product.price * quantity);
    });
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
        // Delivery Address
        GestureDetector(
          onTap: () {
            setState(() {
              isDeliveryAddressExpanded = !isDeliveryAddressExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 24),
                    const SizedBox(width: 8),
                    const Text(
                      'Delivery Address',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Icon(
                      isDeliveryAddressExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                  ],
                ),
                if (isDeliveryAddressExpanded) ...[
                  const SizedBox(height: 16),
                  const Text(
                    '325 15th Eighth Avenue, NewYork',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 32),
                    child: Text('Saepe eaque fugiat ea voluptatum veniam.'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement address change
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Address change functionality coming soon',
                          ),
                        ),
                      );
                    },
                    child: const Text('Change Address'),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Delivery Time
        GestureDetector(
          onTap: () {
            setState(() {
              isDeliveryTimeExpanded = !isDeliveryTimeExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 24),
                    const SizedBox(width: 8),
                    const Text(
                      'Delivery Time',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Icon(
                      isDeliveryTimeExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                  ],
                ),
                if (isDeliveryTimeExpanded) ...[
                  const SizedBox(height: 16),
                  const Text('6:00 pm, Wednesday 20'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement time change
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Time change functionality coming soon',
                          ),
                        ),
                      );
                    },
                    child: const Text('Change Time'),
                  ),
                ],
              ],
            ),
          ),
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
          ...widget.cartProducts.map((product) {
            final quantity = widget.quantities[product.id] ?? 1;
            return _buildOrderRow(
              '${product.title} (x$quantity)',
              '\$${(product.price * quantity).toStringAsFixed(2)}',
            );
          }),
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
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
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
        _buildPaymentMethodOption(
          'PayPal',
          Icons.payment,
          isSelected: selectedPaymentMethod == 'PayPal',
        ),
        _buildPaymentMethodOption(
          'Credit Card',
          Icons.credit_card,
          isSelected: selectedPaymentMethod == 'Credit Card',
        ),
        _buildPaymentMethodOption(
          'Apple Pay',
          Icons.apple,
          isSelected: selectedPaymentMethod == 'Apple Pay',
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Add payment method functionality coming soon'),
              ),
            );
          },
          child: Row(
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
        ),
      ],
    );
  }

  Widget _buildPaymentMethodOption(
    String title,
    IconData icon, {
    bool isSelected = false,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = title;
        });
      },
      child: Padding(
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
          // Show order confirmation dialog
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text('Confirm Order'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Payment Method: $selectedPaymentMethod'),
                      const SizedBox(height: 8),
                      Text(
                        'Total Amount: \$${(widget.cartProducts.fold<double>(0, (sum, product) {
                              final quantity = widget.quantities[product.id] ?? 1;
                              return sum + (product.price * quantity);
                            }) - 4 + 2).toStringAsFixed(2)}',
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => OrdersHistoryScreen(
                                  orders: widget.cartProducts,
                                ),
                          ),
                        );
                      },
                      child: const Text('Confirm'),
                    ),
                  ],
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
