import 'package:flutter/material.dart';
import '../enum/exception_type.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomException implements Exception {
  final ExceptionType type;
  final Object? originalException;
  final String? file;
  final String? method;

  CustomException({
    required this.type,
    this.originalException,
    this.file,
    this.method,
  });

  @override
  String toString() {
    return '''
    Type:\t $type
    Original:\t ${originalException ?? 'None'}
    File:\t ${file ?? 'Unknown'}
    Method:\t ${method ?? 'Unknown'}
    ''';
  }

  /// ### returns 2 size array:
  /// - ### [0] = Error title.
  /// - ### [1] = Error message.
  List<String> getTitleAndMessage(BuildContext context) {
    final AppLocalizations translator = AppLocalizations.of(context)!;
    final List<String> titleAndMessage = ['title', 'message'];

    switch (type) {
      case ExceptionType.loginUserEmpty:
        titleAndMessage[0] = translator.loginError;
        titleAndMessage[1] = translator.loginUserEmpty;
      case ExceptionType.loginPassEmpty:
        titleAndMessage[0] = translator.loginError;
        titleAndMessage[1] = translator.loginPassEmpty;
      case ExceptionType.loginIncorrect:
        titleAndMessage[0] = translator.loginError;
        titleAndMessage[1] = translator.loginIncorrect;
      case ExceptionType.noInternet:
        titleAndMessage[0] = translator.internetError;
        titleAndMessage[1] = translator.internetUnavailable;    }
    assert(titleAndMessage.length == 2, '$titleAndMessage must have 2 elements (title & message)');
    return titleAndMessage;
  }
}
