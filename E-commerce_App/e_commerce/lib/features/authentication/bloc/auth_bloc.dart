import 'package:bloc/bloc.dart';
import 'package:e_commerce/features/authentication/domain/auth_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:e_commerce/features/authentication/data/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository, required CheckAuthStatusUseCase checkAuth, required LoginUseCase login, required SignupUseCase signup, required LogoutUseCase logout}) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<LoginRequested>(_onLoginRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onAuthCheckRequested(
      AuthCheckRequested event, Emitter<AuthState> emit) async {
    // Check for existing session (e.g., Firebase.currentUser)
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
          email: event.email, password: event.password);
      emit(AuthAuthenticated(userId: user.id));
    } catch (error) {
      emit(AuthFailure(error: error.toString()));
    }
  }

  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signUp(
          email: event.email, password: event.password);
      emit(AuthAuthenticated(userId: user.id));
    } catch (error) {
      emit(AuthFailure(error: error.toString()));
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {
    await authRepository.logout();
    emit(AuthUnauthenticated());
  }
}
