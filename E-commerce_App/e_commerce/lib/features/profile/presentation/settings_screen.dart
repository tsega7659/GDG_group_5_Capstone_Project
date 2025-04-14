import 'package:flutter/material.dart';
import '../../../core/routing/routes.dart';
import 'package:e_commerce/features/authentication/bloc/auth_bloc.dart';
import 'package:e_commerce/features/authentication/bloc/auth_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  User? _user;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _getUser();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _getUser() {
    setState(() {
      _user = FirebaseAuth.instance.currentUser;
    });
  }

  Future<void> _handleSignOut(BuildContext context) async {
    final shouldSignOut = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Sign Out'),
            content: const Text('Are you sure you want to sign out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  'Sign Out',
                  style: TextStyle(color: Color(0xFFF55F1F)),
                ),
              ),
            ],
          ),
    );

    if (shouldSignOut == true && mounted) {
      context.read<AuthBloc>().add(LogoutRequested());
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Hero(
          tag: 'settings_button',
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'profile_picture',
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/profile_1.jpeg'),
                  ),
                  title: Text(
                    _user?.displayName ?? 'User',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    _user?.email ?? 'No email',
                    style: const TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildAnimatedHeader('Account', 0),
              const SizedBox(height: 10),

              _buildSettingItem(
                icon: Icons.notifications_outlined,
                title: 'Notification',
                index: 2,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Notifications settings coming soon'),
                    ),
                  );
                },
              ),
              _buildSettingItem(
                icon: Icons.language,
                title: 'Language',
                trailing: 'English',
                index: 3,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Language settings coming soon'),
                    ),
                  );
                },
              ),
              _buildSettingItem(
                icon: Icons.lock_outline,
                title: 'Privacy',
                index: 4,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Privacy settings coming soon'),
                    ),
                  );
                },
              ),
              _buildSettingItem(
                icon: Icons.help_outline,
                title: 'Help Center',
                index: 5,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Help center coming soon')),
                  );
                },
              ),
              _buildSettingItem(
                icon: Icons.info_outline,
                title: 'About us',
                index: 6,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('About us coming soon')),
                  );
                },
              ),
              const SizedBox(height: 24),
              _buildSettingItem(
                icon: Icons.logout,
                title: 'Sign Out',
                textColor: const Color(0xFFF55F1F),
                iconColor: const Color(0xFFF55F1F),
                index: 7,
                onTap: () => _handleSignOut(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedHeader(String text, int index) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-0.5, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.1,
            index * 0.1 + 0.5,
            curve: Curves.easeOut,
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    String? trailing,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
    required int index,
  }) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.1,
            index * 0.1 + 0.5,
            curve: Curves.easeOut,
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: iconColor ?? Colors.black87),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          trailing:
              trailing != null
                  ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        trailing,
                        style: const TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  )
                  : const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onTap,
        ),
      ),
    );
  }
}
