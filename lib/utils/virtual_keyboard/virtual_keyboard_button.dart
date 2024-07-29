import 'dart:io' show Platform;
import 'package:baccus_kitchen/utils/virtual_keyboard/data/initial_case.dart';
import 'package:baccus_kitchen/utils/virtual_keyboard/virtual_keyboard.dart';
import 'package:flutter/material.dart';

class ButtonKeyboard extends StatelessWidget {
  ///Optimized to use in [TextFormField] > [InputDecoration] : icon
  ///
  ///* Visible only in [Platform.Windows].
  ///* [onConfirmCallback] has the user input response as a parameter.
  ///* [option] is the title on the left when [VirtualKeyboard] shows.
  ///* Default [isPassword] = false, if true obscures text input.
  ///* Default [initial] = UPER_CASE; other: NUMERIC or LOWER_CASE.
  ///* Override [margin] & [iconSize] to adjust the Widget.
  const ButtonKeyboard({
    Key? key,
    required this.textController,
    required this.onConfirmCallback,
    required this.option,
    this.isPassword = false,
    this.iconSize = 50.0,
    this.initial = InitialCase.upperCase,
    this.margin = const EdgeInsets.only(left: 8.0, bottom: 12.0, top: 8.0),
  }) : super(key: key);

  final TextEditingController textController;
  final void Function(String) onConfirmCallback;
  final String option;

  final bool isPassword;
  final double iconSize;
  final EdgeInsets? margin;
  final InitialCase initial;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: Platform.isWindows,
      child: Container(
        margin: margin,
        child: IconButton(
          icon: Icon(Icons.keyboard, color: Theme.of(context).colorScheme.onBackground),
          iconSize: iconSize,
          onPressed: () => VirtualKeyboard.show(
            context: context,
            option: option,
            onConfirmCallback: onConfirmCallback,
            controllerText: textController,
            isPassword: isPassword,
            initial: initial,
          ),
        ),
      ),
    );
  }
}
