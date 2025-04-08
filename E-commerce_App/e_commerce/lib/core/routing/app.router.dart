// Manages app navigation by defining named routes.
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Add navigation logic here
    return MaterialPageRoute(builder: (_) => Container());
  }
}

//for the check out screen
import 'package:auto_route/auto_route.dart';
import 'package:e_commerce/core/routing/app.router.dart';
import 'package:e_commerce/features/checkout/presentation/screens/checkout_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    // ... your existing routes
    AutoRoute(
      page: CheckoutScreen,
      fullscreenDialog: true,  // Optional: makes it slide up on iOS
    ),
  ],
)
class $AppRouter {}
