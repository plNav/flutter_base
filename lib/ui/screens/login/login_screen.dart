import 'package:baccus_kitchen/ui/bloc/login/login_bloc.dart';
import 'package:baccus_kitchen/ui/navigation/paths.dart';
import 'package:baccus_kitchen/ui/screens/login/widgets/login_body.dart';
import 'package:baccus_kitchen/ui/widgets/error_center.dart';
import 'package:baccus_kitchen/ui/widgets/loading_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, loginState) {
          if (loginState.status == LoginStatus.authSuccess) {
            Navigator.of(context).pushReplacementNamed(home);
          }
        },
        builder: (context, loginState) {
          if ([LoginStatus.authenticating, LoginStatus.authSuccess].contains(loginState.status)) {
            return const LoadingCenter();
          }
          if (loginState.status == LoginStatus.authFailed) {
            return const ErrorCenter();
          }
          return const LoginBody();
        },
      ),
    );
  }
}
