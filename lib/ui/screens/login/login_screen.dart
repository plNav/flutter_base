import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../utils/console_printer.dart';
import '../../bloc/login/login_bloc.dart';
import '../../navigation/paths.dart';
import '../../widgets/appbar_custom.dart';
import '../../widgets/loading_center.dart';
import '../../widgets/popup_info.dart';
import 'widgets/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    final colorScheme = Theme.of(context).colorScheme;
    printCScreenSize(context, 'Login Screen');

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: const CustomAppbar(
        title: 'PROJECT APP NAME!',
      ),
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
            return LoadingCenter(text: AppLocalizations.of(context)!.loadingAuth);
          }
          return const LoginBody();
        },
      ),
    );
  }
}
