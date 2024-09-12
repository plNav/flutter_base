import 'package:baccus_kitchen/data/enum/exception_type.dart';

class CustomException implements Exception {
  final ExceptionType type;
  final Exception? originalException;
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

  // Returns
  List<String> getFixedSizeArray() {
    const List<String> result = ["", ""];
    result[0] = 'asdf';
    result[1] = "asdfasdf";
    assert(result.length == 2, 'The array must have exactly 2 elements');
    return result;
  }



}
