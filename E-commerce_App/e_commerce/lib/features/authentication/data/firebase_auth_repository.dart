

import 'package:e_commerce/features/authentication/data/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:e_commerce/core/models/user_model.dart';


/// A FirebaseAuth‑backed implementation of [AuthRepository].
class FirebaseAuthRepository implements AuthRepository {
  final fb.FirebaseAuth _firebaseAuth;

  FirebaseAuthRepository({fb.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? fb.FirebaseAuth.instance;

  @override
  Future<User?> getCurrentUser() async {
    final u = _firebaseAuth.currentUser;
    if (u == null) return null;
    return User(
      id:    u.uid,
      name:  u.displayName ?? '',
      email: u.email ?? '',
    );
  }

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    final cred = await _firebaseAuth.signInWithEmailAndPassword(
      email:    email,
      password: password,
    );
    final u = cred.user!;
    return User(
      id:    u.uid,
      name:  u.displayName ?? '',
      email: u.email ?? '',
    );
  }

  @override
  Future<User> signUp({
    required String email,
    required String password,
  }) async {
    final cred = await _firebaseAuth.createUserWithEmailAndPassword(
      email:    email,
      password: password,
    );
    final u = cred.user!;
    return User(
      id:    u.uid,
      name:  u.displayName ?? '',
      email: u.email ?? '',
    );
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
