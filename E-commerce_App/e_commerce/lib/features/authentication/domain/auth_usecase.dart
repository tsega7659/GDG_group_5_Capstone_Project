// lib/domain/usecases/auth_usecases.dart

import 'package:e_commerce/core/models/user_model.dart';
import 'package:e_commerce/features/authentication/data/auth_repository.dart';


class CheckAuthStatusUseCase {
  final AuthRepository _repo;
  CheckAuthStatusUseCase(this._repo);

  Future<User?> call() => _repo.getCurrentUser();
}

class LoginUseCase {
  final AuthRepository _repo;
  LoginUseCase(this._repo);

  Future<User> call({
    required String email,
    required String password,
  }) => _repo.login(email: email, password: password);
}

class SignupUseCase {
  final AuthRepository _repo;
  SignupUseCase(this._repo);

  Future<User> call({
    required String email,
    required String password,
  }) => _repo.signUp(email: email, password: password);
}

class LogoutUseCase {
  final AuthRepository _repo;
  LogoutUseCase(this._repo);

  Future<void> call() => _repo.logout();
}
