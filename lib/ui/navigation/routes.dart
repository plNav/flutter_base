import 'package:baccus_kitchen/ui/navigation/paths.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (_) => const SizedBox(),
      login: (context) {
/*        return BlocProvider(
          create: (context) => LoginBloc(
            authRepository: context.read<IAuthRepository>(),
            loginRepository: context.read<ILoginRepository>(),
          )
          // Comment-Uncomment this ..addIf event for Debug AutoLogin.
            ..addIf(kDebugMode && isAutoLogin,
                ValidateLoginEvent(username: credentials.user, password: credentials.pass)),
          child: const LoginScreen(),
        );*/
        return const SizedBox();
      },
    };
  }
}
