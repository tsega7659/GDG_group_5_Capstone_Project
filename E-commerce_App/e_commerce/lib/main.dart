import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:e_commerce/core/routing/app_router.dart';
import 'package:e_commerce/core/routing/routes.dart';
import 'package:e_commerce/features/authentication/bloc/auth_bloc.dart';
import 'package:e_commerce/features/authentication/bloc/auth_event.dart';
import 'package:e_commerce/features/authentication/data/firebase_auth_repository.dart';
import 'package:e_commerce/features/authentication/domain/auth_usecase.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _authRepo = FirebaseAuthRepository();
  late final _checkAuth = CheckAuthStatusUseCase(_authRepo);
  late final _loginUC = LoginUseCase(_authRepo);
  late final _signupUC = SignupUseCase(_authRepo);
  late final _logoutUC = LogoutUseCase(_authRepo);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => AuthBloc(
            authRepository: _authRepo,
            checkAuth: _checkAuth,
            login: _loginUC,
            signup: _signupUC,
            logout: _logoutUC,
          )..add(AuthCheckRequested()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.login,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
