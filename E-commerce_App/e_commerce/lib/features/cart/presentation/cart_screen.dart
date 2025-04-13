import 'package:e_commerce/core/models/product_model.dart';
import 'package:e_commerce/features/product/presentation/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  final List<Product> selectedProducts;

  const CartScreen({Key? key, required this.selectedProducts})
    : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> cartProducts = [];
  Map<int, int> productQuantities = {};

  @override
  void initState() {
    super.initState();
    cartProducts = widget.selectedProducts;
    // Initialize quantities for all products
    for (var product in cartProducts) {
      productQuantities[product.id] = productQuantities[product.id] ?? 1;
    }
  }

  void addProduct(Product product) {
    setState(() {
      if (!cartProducts.any((p) => p.id == product.id)) {
        cartProducts.add(product);
        productQuantities[product.id] = 1;
      } else {
        // If product already exists, increase quantity
        productQuantities[product.id] =
            (productQuantities[product.id] ?? 0) + 1;
      }
    });
  }

  void updateQuantity(int productId, int newQuantity) {
    if (newQuantity < 1) return;
    setState(() {
      productQuantities[productId] = newQuantity;
    });
  }

  void removeProduct(int productId) {
    setState(() {
      cartProducts.removeWhere((product) => product.id == productId);
      productQuantities.remove(productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = cartProducts.fold(0, (sum, product) {
      final quantity = productQuantities[product.id] ?? 1;
      return sum + (product.price * quantity);
    });
    double discount = 4;
    double deliveryCharges = 2;
    double total = subtotal - discount + deliveryCharges;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F3F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F3F6),
        elevation: 0,
        title: const Text('Cart', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder:
                    (context) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.delete),
                          title: const Text('Clear Cart'),
                          onTap: () {
                            setState(() {
                              cartProducts.clear();
                              productQuantities.clear();
                            });
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.shopping_bag),
                          title: const Text('View Order History'),
                          onTap: () {
                            // TODO: Implement order history
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child:
                cartProducts.isEmpty
                    ? const Center(child: Text('Your cart is empty'))
                    : ListView.builder(
                      itemCount: cartProducts.length,
                      itemBuilder: (context, index) {
                        final product = cartProducts[index];
                        final quantity = productQuantities[product.id] ?? 1;
                        return CartItem(
                          cartItem: CartItemModel(
                            name: product.title,
                            brand: product.category,
                            price: product.price,
                            imageUrl: product.image,
                          ),
                          quantity: quantity,
                          onQuantityChanged:
                              (newQuantity) =>
                                  updateQuantity(product.id, newQuantity),
                          onDelete: () => removeProduct(product.id),
                        );
                      },
                    ),
          ),
          OrderSummary(
            totalItems: cartProducts.fold(
              0,
              (sum, product) => sum + (productQuantities[product.id] ?? 1),
            ),
            subtotal: subtotal,
            discount: discount,
            deliveryCharges: deliveryCharges,
            total: total,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6055DB),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () async {
                final newProduct = await Navigator.push<Product>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductListScreen(),
                  ),
                );
                if (newProduct != null) {
                  addProduct(newProduct);
                }
              },
              child: const Text(
                'Add Product',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6055DB),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed:
                  cartProducts.isEmpty
                      ? null
                      : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => CheckoutScreen(
                                  cartProducts: cartProducts,
                                  quantities: productQuantities,
                                  
                                ),
                          ),
                        );
                      },
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
  const CartItem({
    Key? key,
    required this.cartItem,
    required this.quantity,
    required this.onQuantityChanged,
    required this.onDelete,
  }) : super(key: key);

  final CartItemModel cartItem;
  final int quantity;
  final Function(int) onQuantityChanged;
  final VoidCallback onDelete;

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
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
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
                            color: const Color(0xFF6055DB),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.remove, color: Colors.white),
                            onPressed: () => onQuantityChanged(quantity - 1),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            quantity.toString().padLeft(2, '0'),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF6055DB),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add, color: Colors.white),
                            onPressed: () => onQuantityChanged(quantity + 1),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: onDelete,
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
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Items', style: TextStyle(fontSize: 16)),
              Text(totalItems.toString(), style: const TextStyle(fontSize: 16)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal', style: TextStyle(fontSize: 16)),
              Text(
                '\$${subtotal.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Discount', style: TextStyle(fontSize: 16)),
              Text(
                '\$${discount.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Delivery Charges', style: TextStyle(fontSize: 16)),
              Text(
                '\$${deliveryCharges.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const Divider(thickness: 1.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: const TextStyle(
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
