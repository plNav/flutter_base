import 'package:flutter/material.dart';

class ErrorCenter extends StatelessWidget {
  const ErrorCenter({super.key, this.error = 'Undefined Error'});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(error));
  }
}
