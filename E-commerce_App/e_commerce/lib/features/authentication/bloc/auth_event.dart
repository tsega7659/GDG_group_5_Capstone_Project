import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;

  SignUpRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LogoutRequested extends AuthEvent {}
