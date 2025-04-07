// This is the CartScreen widget that displays the cart items and allows users to proceed to checkout.
import 'package:flutter/material.dart';
ElevatedButton(
  onPressed: () {
    // Either use auto_route:
    context.router.push(const CheckoutRoute());
    
    // Or basic navigation:
    // Navigator.push(context, MaterialPageRoute(
    //   builder: (_) => const CheckoutScreen()));
  },
  child: const Text('Proceed to Checkout'),
)