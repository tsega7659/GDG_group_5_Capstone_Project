import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String userId; // or a User model

  AuthAuthenticated({required this.userId});

  @override
  List<Object> get props => [userId];
}

class AuthUnauthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure({required this.error});

  @override
  List<Object> get props => [error];
}
