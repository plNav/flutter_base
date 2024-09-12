import 'package:baccus_kitchen/domain/repositories/abstractions/i_login_repository.dart';
import 'package:baccus_kitchen/domain/services/implementations/login_service.dart';
import 'package:baccus_kitchen/ui/bloc/home/home_bloc.dart';
import 'package:baccus_kitchen/ui/bloc/login/login_bloc.dart';
import 'package:baccus_kitchen/ui/navigation/paths.dart';
import 'package:baccus_kitchen/ui/screens/home/home_screen.dart';
import 'package:baccus_kitchen/ui/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (_) => const Text('TODO: Splash Screen'),
      login: (context) => BlocProvider(
            create: (context) => LoginBloc(
              loginService: LoginService(loginRepository: context.read<ILoginRepository>()),
            ),
            child: const LoginScreen(),
          ),
      home: (context) => BlocProvider(
            create: (context) => HomeBloc(
              loginService: LoginService(loginRepository: context.read<ILoginRepository>()),
            )..add(GetUserInfoEvent()),
            child: const HomeScreen(),
          ),
    };
  }
}
