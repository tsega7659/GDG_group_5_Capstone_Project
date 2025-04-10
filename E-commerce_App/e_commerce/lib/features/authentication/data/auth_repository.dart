import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:e_commerce/core/models/user_model.dart'; // Import your domain User model

class AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  AuthRepository(this._firebaseAuth);

  Future<User> login({required String email, required String password}) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return User(
      id: userCredential.user!.uid,
      name: userCredential.user!.displayName ?? '', // Add if required
      email: userCredential.user!.email ?? '', // Add if required
    ); // Use the domain User class
  }

  Future<User> signUp({required String email, required String password}) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return User(
      id: userCredential.user!.uid,
      name: userCredential.user!.displayName ?? '', // Add if required
      email: userCredential.user!.email ?? '', // Add if required
    ); // Use the domain User class
  }

  Future<User?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    return user != null
        ? User(
          id: user.uid,
          name: user.displayName ?? '', // Add if required
          email: user.email ?? '', // Add if required
        )
        : null; // Use the domain User class
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
