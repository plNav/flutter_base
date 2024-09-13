import 'dart:async';

import 'package:baccus_kitchen/utils/console_printer.dart';
import 'package:baccus_kitchen/utils/virtual_keyboard/data/initial_case.dart';
import 'package:baccus_kitchen/utils/virtual_keyboard/virtual_keyboard_body.dart';
import 'package:flutter/material.dart';

/* Usage Example
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
 */

///Shows and Closes a virtual keyboard to handle an ui [TextEditingController]
///
///* Use this class only if [Platform.Windows]
///* Only 2 static void methods: [show] & [dismiss]
class VirtualKeyboard {
  static const double bottomSheetHeight = 400.0;
  static const double bottomSheetWidth = 1000.0;

  ///Closes [VirtualKeyboard] and triggers [onConfirmCallback]
  static void dismiss({
    required String option,
    required TextEditingController controllerText,
    required BuildContext context,
    required void Function(String) onConfirmCallback,
  }) {
    printC(blue, 'Keyboard CLOSED for [ $option ], with TEXT => ${controllerText.value.text}');
    Navigator.of(context).pop();
    onConfirmCallback(controllerText.value.text);
  }

  ///[showModalBottomSheet] for tactile input.
  ///
  ///* [onConfirmCallback] has the input as a parameter.
  ///* [option] is the left title when [VirtualKeyboard] shows.
  ///* Default [isPassword] = false, if true obscures text input.
  ///* Default [initial] = UPER_CASE; other: NUMERIC or LOWER_CASE.
  static FutureOr<void> show({
    required BuildContext context,
    required String option,
    required TextEditingController controllerText,
    required void Function(String) onConfirmCallback,
    bool isPassword = false,
    InitialCase initial = InitialCase.upperCase,
  }) {
    printC(cyan, 'virtualKeyboard OPENED for [ $option ]');
    showModalBottomSheet<void>(
      isDismissible: false,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      isScrollControlled: true,
      constraints: const BoxConstraints(
        minHeight: VirtualKeyboard.bottomSheetHeight,
        maxHeight: VirtualKeyboard.bottomSheetHeight,
        minWidth: VirtualKeyboard.bottomSheetWidth,
        maxWidth: VirtualKeyboard.bottomSheetWidth,
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Container(
              width: double.infinity,
              height: 65.0,
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///OPTION SELECTED
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    child: Text(
                      option,
                      style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),

                  ///TEXT INPUT
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextFormField(
                        key: const Key('VirtualKeyboardTextFormField'),
                        controller: controllerText,
                        obscureText: isPassword,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(border: InputBorder.none),
                        style: const TextStyle(fontSize: 26),
                      ),
                    ),
                  ),

                  ///CONFIRM BUTTON
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () => dismiss(
                      option: option,
                      controllerText: controllerText,
                      context: context,
                      onConfirmCallback: onConfirmCallback,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Icon(
                        Icons.check,
                        color: Theme.of(context).colorScheme.surface,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            OnscreenKeyboard(
              value: controllerText.value.text,
              initialCase: initial,
              backgroundColor: Colors.transparent,
              buttonColor: Colors.transparent,
              onChanged: (value) => controllerText.text = (value ?? ''),
            ),
          ],
        );
      },
    );
  }
}
