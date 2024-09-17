import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/abstractions/i_login_repository.dart';
import '../../domain/repositories/abstractions/i_persistence_config_repository.dart';
import '../../domain/repositories/abstractions/i_persistence_theme_repository.dart';
import '../../domain/services/implementations/login_service.dart';
import '../../domain/services/implementations/persistence_config_service.dart';
import '../../domain/services/implementations/persistence_theme_service.dart';
import '../bloc/home/home_bloc.dart';
import '../bloc/login/login_bloc.dart';
import '../screens/home/home_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/preview/preview_screen.dart';
import 'paths.dart';

class Routes {
  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (_) => const Text('TODO: Splash Screen'),
      login: (context) => BlocProvider(
            create: (context) => LoginBloc(
              loginService: LoginService(loginRepository: context.read<ILoginRepository>()),
              persistenceConfigService: PersistenceConfigService(
                  persistenceConfigRepository: context.read<IPersistenceConfigRepository>()),
            )..add(LoadPersistedConfigEvent()),
            child: const LoginScreen(),
          ),
      home: (context) => BlocProvider(
            create: (context) => HomeBloc(
                loginService: LoginService(loginRepository: context.read<ILoginRepository>()),
                persistenceConfigService: PersistenceConfigService(
                    persistenceConfigRepository: context.read<IPersistenceConfigRepository>()),
                persistenceThemeService: PersistenceThemeService(
                    persistenceThemeRepository: context.read<IPersistenceThemeRepository>()))
              ..add(GetUserInfoEvent()),
            child: const HomeScreen(),
          ),
      preview: (_) => const PreviewScreen(),
    };
  }
}
