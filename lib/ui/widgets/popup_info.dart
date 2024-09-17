import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'button_custom.dart';

class PopupInfo {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    Function()? onConfirm,
    bool isDismissible = true,
    bool isWarning = false,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: isDismissible,
      barrierLabel: '',
      pageBuilder: (_, __, ___) => const SizedBox(),
      // We use this boilerplate to animate show and dismiss
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (_, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: _PopupInfoContent(
              title: title,
              message: message,
              onConfirm: onConfirm,
              isWarning: isWarning,
            ),
          ),
        );
      },
    );
  }

  static void handleExitApp(BuildContext context) {
    final AppLocalizations translator = AppLocalizations.of(context)!;
    show(
      context: context,
      isWarning: true,
      title: translator.exit,
      message: translator.exitQuestion,
      onConfirm: () => SystemNavigator.pop(),
    );
  }
}

class _PopupInfoContent extends StatelessWidget {
  const _PopupInfoContent({
    required this.title,
    required this.message,
    required this.isWarning,
    this.onConfirm,
  });

  final String title;
  final String message;
  final bool isWarning;
  final Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations translator = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        CustomButton(
          buttonKey: const Key('Info Popup Button'),
          isError: isWarning,
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm?.call();
          },
          child: Text(translator.accept),
        )
      ],
    );
  }
}
