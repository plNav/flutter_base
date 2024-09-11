import 'dart:convert';
import 'package:baccus_kitchen/data/model/environment.dart';
import 'package:encrypt/encrypt.dart' as crypto; // AES encryption package
import 'package:flutter/foundation.dart'; // For kDebugMode
import 'dart:math';

class CryptoClient {
  // Singleton pattern for the CryptoClient
  static final CryptoClient _cryptoInstance = CryptoClient._internal();

  // Lazy initialized secret key
  late String _secretKey;

  factory CryptoClient() {
    return _cryptoInstance;
  }

  CryptoClient._internal() {
    _initializeSecretKey();
  }

  // AES Encryption & Decryption: Use a 256-bit key (32 bytes) with an Initialization Vector (IV)
  final _keySize = 32; // 256-bit key size for AES
  final _ivSize = 16; // AES block size (128 bits) for IV

  /*
   * The AES-256 key must be exactly 32 characters (256 bits).
   * Example of a valid secret key (32 bytes):
   *
   * 'aBcDeFgHiJkLmNoPqRsTuVwXyZ012345'
   *
   * This key should be stored securely and never shared in production.
   * Any key that is not 32 characters long will result in a random key generation.
   */

  // Helper function to initialize the secret key from the environment
  void _initializeSecretKey() {
    final environmentSecretKey = Environment.getEnvCredentials().secretKey;

    if (environmentSecretKey.length != _keySize) {
      if (kDebugMode) {
        print('Warning: Secret key length is not valid. Generating a random 256-bit key for debugging.');
        _secretKey = _generateRandomKeyAsString(); // Generate and assign a random key for debugging
        print('Generated random key: $_secretKey'); // Print the random key
      } else {
        throw Exception('Secret key length must be exactly 32 characters (256 bits).');
      }
    } else {
      _secretKey = environmentSecretKey; // Assign the valid secret key from the environment
    }
  }

  // Helper to generate a random 256-bit key (32 characters) as a String
  String _generateRandomKeyAsString() {
    final random = Random.secure();
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(_keySize, (_) => chars[random.nextInt(chars.length)]).join();
  }

  // Encrypt the given plaintext using AES
  String encode(String plainText) {
    try {
      final keyBytes = Uint8List.fromList(utf8.encode(_secretKey)); // Use the initialized _secretKey
      final iv = crypto.IV.fromSecureRandom(_ivSize); // Generate a random IV

      final encrypter = crypto.Encrypter(crypto.AES(crypto.Key.fromUtf8(_secretKey), mode: crypto.AESMode.cbc)); // AES in CBC mode
      final encrypted = encrypter.encrypt(plainText, iv: iv);

      // Return Base64-encoded encrypted string with IV prefixed for later decryption
      return base64Encode(iv.bytes + encrypted.bytes);
    } catch (e) {
      throw Exception('Encryption failed: ${e.toString()}');
    }
  }

  // Decrypt the given ciphertext using AES
  String decode(String cipherText) {
    try {
      final keyBytes = Uint8List.fromList(utf8.encode(_secretKey)); // Use the initialized _secretKey
      final encryptedBytes = base64Decode(cipherText);

      // Extract the IV (first 16 bytes) from the encrypted bytes
      final iv = crypto.IV(encryptedBytes.sublist(0, _ivSize));

      // Extract the actual encrypted data (everything after the IV)
      final encryptedData = encryptedBytes.sublist(_ivSize);

      final encrypter = crypto.Encrypter(crypto.AES(crypto.Key.fromUtf8(_secretKey), mode: crypto.AESMode.cbc)); // AES in CBC mode
      final decrypted = encrypter.decrypt(crypto.Encrypted(Uint8List.fromList(encryptedData)), iv: iv);

      return decrypted;
    } catch (e) {
      throw Exception('Decryption failed: ${e.toString()}');
    }
  }
}