
import 'package:e_commerce/core/models/user_model.dart';


abstract class AuthRepository {

  Future<User?> getCurrentUser();

 
  Future<User> login({
    required String email,
    required String password,
  });


  Future<User> signUp({
    required String email,
    required String password,
  });

 
  Future<void> logout();
}
