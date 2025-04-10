import 'package:bloc/bloc.dart';
import 'package:e_commerce/features/authentication/domain/auth_usecase.dart';
import 'package:e_commerce/features/authentication/data/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({
    required this.authRepository,
    required CheckAuthStatusUseCase checkAuth,
    required LoginUseCase login,
    required SignupUseCase signup,
    required LogoutUseCase logout,
  }) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<LoginRequested>(_onLoginRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onAuthCheckRequested(
      AuthCheckRequested event, Emitter<AuthState> emit) async {
    final user = await authRepository.getCurrentUser();
    if (user != null) {
      emit(AuthAuthenticated(userId: user.id));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.login(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated(userId: user.id));
    } on firebase_auth.FirebaseAuthException catch (e) {
      emit(AuthFailure(error: e.message ?? 'Login failed'));
    } catch (e) {
      emit(AuthFailure(error: 'An unexpected error occurred during login'));
    }
  }

  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signUp(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated(userId: user.id));
    } on firebase_auth.FirebaseAuthException catch (e) {
      emit(AuthFailure(error: e.message ?? 'Signup failed'));
    } catch (e) {
      emit(AuthFailure(error: 'An unexpected error occurred during signup'));
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {
    await authRepository.logout();
    emit(AuthUnauthenticated());
  }
}