import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Widget label;
  const ButtonWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: label,
    );
  }
}
