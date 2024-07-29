import 'package:baccus_kitchen/utils/console_printer.dart';
import 'package:baccus_kitchen/utils/virtual_keyboard/virtual_keyboard.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _urlController = TextEditingController();
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  void _submit() {
    final url = _urlController.text;
    final user = _userController.text;
    final pass = _passController.text;

    // Print the credentials for now
    print('URL: $url, User: $user, Pass: $pass');
  }

  @override
  void dispose() {
    _urlController.dispose();
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(labelText: 'URL'),
            ),
            TextField(
              controller: _userController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              onTap: () {
                VirtualKeyboard.show(
                    context: context,
                    option: 'Escribe!',
                    controllerText: _passController,
                    onConfirmCallback: (String res) {
                      printC(purpleB, 'Input $res');
                    });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
