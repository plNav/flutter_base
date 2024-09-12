import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PopupInfo {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    Function()? onConfirm,
    bool isDismissible = true,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: isDismissible,
      barrierLabel: '',
      pageBuilder: (_, __, ___) => const SizedBox(),
      // We use this boilerplate to animate when popup show or dismiss
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
            ),
          ),
        );
      },
    );
  }
}

class _PopupInfoContent extends StatelessWidget {
  const _PopupInfoContent({required this.title, required this.message, this.onConfirm});

  final String title;
  final String message;
  final Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations translator = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        ElevatedButton(
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
