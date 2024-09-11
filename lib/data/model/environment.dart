import 'package:baccus_kitchen/utils/console_printer.dart';

/// Provides Env Variables. Private Constructor - does not need Equatable imp or copyWith method
class Environment {
  final String baseUrl;
  final String secretKey;

  // Private constructor, so the class cannot be instantiated externally
  const Environment._({required this.baseUrl, required this.secretKey});

  // ⚠ Never hardcode real data in defaultValue.
  static Environment getEnvCredentials() {
    const baseUrl = String.fromEnvironment('PROJECT_URL', defaultValue: 'DEFAULT URL');
    const secretKey = String.fromEnvironment('PROJECT_KEY', defaultValue: 'DEFAULT KEY');

    printC(purple, '''
    DEBUG ENVIRONMENT
      - BaseUrl: $baseUrl
      - SecretKey: $secretKey
    ''');

    return const Environment._(baseUrl: baseUrl, secretKey: secretKey);
  }
}
