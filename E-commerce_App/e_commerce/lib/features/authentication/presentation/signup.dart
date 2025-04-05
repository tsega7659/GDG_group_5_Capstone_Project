// lib/presentation/screens/signup_screen.dart

import 'package:e_commerce/core/routing/routes.dart';
import 'package:e_commerce/core/utils/validators.dart';
import 'package:e_commerce/features/authentication/bloc/auth_bloc.dart';
import 'package:e_commerce/features/authentication/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/features/authentication/bloc/auth_event.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey    = GlobalKey<FormState>();
  final _nameCtrl   = TextEditingController();
  final _emailCtrl  = TextEditingController();
  final _passCtrl   = TextEditingController();
  bool  _obscure    = true;

  @override
  Widget build(BuildContext context) {
    final purple = const Color(0xFF6C63FF);

    return Scaffold(
      backgroundColor: purple,
      body: Stack(
        children: [
          // Purple curved header
          ClipPath(
            clipper: _HeaderClipper(),
            child: Container(
              height: 250,
              color: purple,
            ),
          ),

          // White form card
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 150),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title
                    Text(
                      'Sign Up',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: purple,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Form
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // User Name
                          TextFormField(
                            controller: _nameCtrl,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: 'User Name',
                              border: UnderlineInputBorder(),
                            ),
                            validator: (val) {
                              if (val == null || val.isEmpty) return 'Name required';
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          // Email
                          TextFormField(
                            controller: _emailCtrl,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              hintText: 'Email',
                              border: UnderlineInputBorder(),
                            ),
                            validator: Validators.validateEmail,
                          ),
                          const SizedBox(height: 20),

                          // Password
                          TextFormField(
                            controller: _passCtrl,
                            obscureText: _obscure,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              hintText: 'Password',
                              border: const UnderlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscure ? Icons.visibility_off : Icons.visibility,
                                ),
                                onPressed: () => setState(() => _obscure = !_obscure),
                              ),
                            ),
                            validator: Validators.validatePassword,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Sign Up button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: purple,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            SignUpRequested(
                              email:    _emailCtrl.text.trim(),
                              password: _passCtrl.text.trim(),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Log in link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushReplacementNamed(context, AppRoutes.login),
                          child: Text(
                            'Log in',
                            style: TextStyle(
                              color: purple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Loading indicator
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

// Reuse the same header clipper
class _HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
      size.width / 2, size.height,
      size.width, size.height - 60,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
