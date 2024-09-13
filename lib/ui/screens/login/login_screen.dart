import 'package:baccus_kitchen/ui/bloc/login/login_bloc.dart';
import 'package:baccus_kitchen/ui/navigation/paths.dart';
import 'package:baccus_kitchen/ui/screens/login/widgets/login_body.dart';
import 'package:baccus_kitchen/ui/widgets/loading_center.dart';
import 'package:baccus_kitchen/ui/widgets/popup_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, loginState) {
          if (loginState.status == LoginStatus.authSuccess) {
            Navigator.of(context).pushReplacementNamed(home);
          }
          if (loginState.status == LoginStatus.authFailed) {
            final titleAndMessage = loginState.error!.getTitleAndMessage(context);
            PopupInfo.show(
              context: context,
              title: titleAndMessage[0],
              message: titleAndMessage[1],
              onConfirm: () => loginBloc.add(ConfirmErrorEvent()),
            );
          }
        },
        builder: (context, loginState) {
          if ([LoginStatus.authenticating, LoginStatus.authSuccess].contains(loginState.status)) {
            return const LoadingCenter();
          }
          return const LoginBody();
        },
      ),
    );
  }
}
