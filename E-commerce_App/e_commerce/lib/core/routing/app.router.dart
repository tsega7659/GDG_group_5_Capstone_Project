import 'package:e_commerce/features/Search/presentation/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/features/home/presentation/home_screen.dart';
import 'package:e_commerce/features/cart/presentation/cart_screen.dart';
import 'package:e_commerce/features/profile/presentation/profile_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const BottomNavBar());
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        unselectedItemColor: Colors.grey, 
        selectedItemColor: Color(0xFF6055DB), 
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 40), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 40),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, size: 40),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 40),
            label: '',
          ),
        ],
      ),
    );
  }
}
