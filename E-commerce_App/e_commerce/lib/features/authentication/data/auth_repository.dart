// lib/domain/repositories/auth_repository.dart

import 'package:e_commerce/core/models/user_model.dart';

/// Authentication contract for the domain/use‑case layer.
abstract class AuthRepository {
  /// Returns the currently signed‑in user, or null if none.
  Future<User?> getCurrentUser();

  /// Attempts to sign in. Throws on failure.
  Future<User> login({
    required String email,
    required String password,
  });

  /// Attempts to create a new account. Throws on failure.
  Future<User> signUp({
    required String email,
    required String password,
  });

  /// Signs out the current user. Throws on failure.
  Future<void> logout();
}
