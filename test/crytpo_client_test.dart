import 'package:baccus_kitchen/domain/clients/crypto_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CryptoClient Tests', () {
    late final CryptoClient cryptoClient;

    setUp(() => cryptoClient = CryptoClient());

    test('Encryption and decryption should work correctly with a valid key in debug mode', () {
      const plainText = 'Hello, secure world!';

      // Encrypt the text
      final encryptedText = cryptoClient.encode(plainText);
      expect(encryptedText, isNotNull);
      expect(encryptedText, isNot(plainText));

      // Decrypt the text
      final decryptedText = cryptoClient.decode(encryptedText);
      expect(decryptedText, plainText);
    });
  });
}
