import 'package:baccus_kitchen/data/model/user.dart';
import 'package:baccus_kitchen/ui/bloc/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  late final LoginBloc _loginBloc;
  final _userController = TextEditingController();
  final _passController = TextEditingController();

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

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _userController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: _passController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Login'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _loginBloc.add(TestIsarEvent()),
            child: const Text('Test Isar'),
          ),
        ],
      ),
    );
  }
}
