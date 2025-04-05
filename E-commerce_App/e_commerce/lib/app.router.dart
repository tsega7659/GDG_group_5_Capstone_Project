import 'package:e_commerce/core/routing/routes.dart';
import 'package:e_commerce/features/authentication/presentation/login_screen.dart';
import 'package:e_commerce/features/authentication/presentation/signup.dart';
import 'package:flutter/material.dart';


class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());

      

      default:
        // ← Make sure to always return something
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined for this path')),
          ),
        );
    }
  }
}