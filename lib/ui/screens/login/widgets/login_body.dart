import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../data/model/user.dart';
import '../../../bloc/login/login_bloc.dart';
import '../../../widgets/button_custom.dart';
import '../../../widgets/responsive_layout.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  late final LoginBloc _loginBloc;
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _loginBloc = context.read<LoginBloc>();
  }

  _submit() {
    final user = _userController.text;
    final pass = _passController.text;
    final inputUser = User(id: '', name: user, password: pass);
    _loginBloc.add(InputUserEvent(user: inputUser));
  }

  _togglePasswordVisibility() => setState(() => _showPassword = !_showPassword);

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RLayout(
      mobile: _buildFormColumnCentered(),
      tablet: _buildFormColumnWithBorder(),
    );
  }

  Center _buildFormColumnCentered() => Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          height: 250.0,
          child: _buildFormColumn(),
        ),
      );

  Center _buildFormColumnWithBorder() => Center(
        child: Container(
          key: const Key('Login Border'),
          constraints: const BoxConstraints(maxWidth: 500.0, maxHeight: 350.0),
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: _buildFormColumn(),
        ),
      );

  Column _buildFormColumn() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            key: const Key('Login Input Username'),
            controller: _userController,
            autofocus: false,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: AppLocalizations.of(context)!.username),
          ),
          TextField(
            key: const Key('Login Input Password'),
            controller: _passController,
            obscureText: !_showPassword,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.password,
              suffixIcon: IconButton(
                key: const Key('Login Toggle Visibility'),
                icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                onPressed: _togglePasswordVisibility,
              ),
            ),
          ),
          CustomButton(
            buttonKey: const Key('Login Button'),
            onPressed: _submit,
            fixedWidth: 300.0,
            text: AppLocalizations.of(context)!.login,
          ),
        ],
      );
}
