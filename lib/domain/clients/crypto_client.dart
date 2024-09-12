import 'dart:convert';
import 'dart:math';

import 'package:baccus_kitchen/data/model/environment.dart';
import 'package:baccus_kitchen/utils/console_printer.dart';
import 'package:encrypt/encrypt.dart' as crypto;
import 'package:flutter/foundation.dart';

/// The AES-256 key from [Environment] must be exactly 32 characters (256 bits).
/// If there is no valid key in [kDebugMode] it will be generated automatically, in production
/// throws an error.
/// Example of a valid key: 'aBcDeFgHiJkLmNoPqRsTuVwXyZ012345'
/// 2 public methods [encode] and [decode]
class CryptoClient {
  static final CryptoClient _cryptoInstance = CryptoClient._internal();

  late final String _secretKey;

  factory CryptoClient() => _cryptoInstance;

  CryptoClient._internal() {
    _initializeSecretKey();
  }

  // AES Encryption & Decryption: Use a 256-bit key (32 bytes) with an Initialization Vector (IV)
  final _keySize = 32; // 256-bit key size for AES
  final _ivSize = 16; // AES block size (128 bits) for IV

  _initializeSecretKey() {
    final environmentSecretKey = Environment.getEnvCredentials().secretKey;
    if (environmentSecretKey.length == _keySize) {
      _secretKey = environmentSecretKey;
      return;
    }
    if (!kDebugMode) {
      throw Exception('Secret key length must be exactly 32 characters (256 bits).');
    }
    printC(yellow, 'Warning: Key length not valid. Generating a random 256-bit key for debugging.');
    _secretKey = _generateRandomKeyAsString();
    printC(warning, 'Generated random key: $_secretKey');
  }

  String _generateRandomKeyAsString() {
    final random = Random.secure();
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(_keySize, (_) => chars[random.nextInt(chars.length)]).join();
  }

  /// Encrypt the given plaintext using AES
  String encode(String plainText) {
    try {
      final iv = crypto.IV.fromSecureRandom(_ivSize);
      final key = crypto.Key.fromUtf8(_secretKey);
      final encrypter = crypto.Encrypter(crypto.AES(key, mode: crypto.AESMode.cbc));
      final encrypted = encrypter.encrypt(plainText, iv: iv);
      return base64Encode(iv.bytes + encrypted.bytes);
    } catch (e) {
      throw Exception('Encryption failed: ${e.toString()}');
    }
  }

  /// Decrypt the given ciphertext using AES
  String decode(String cipherText) {
    try {
      final encryptedBytes = base64Decode(cipherText);
      final iv = crypto.IV(encryptedBytes.sublist(0, _ivSize));
      final encryptedData = encryptedBytes.sublist(_ivSize);
      final key = crypto.Key.fromUtf8(_secretKey);
      final encrypter = crypto.Encrypter(crypto.AES(key, mode: crypto.AESMode.cbc));
      final data = Uint8List.fromList(encryptedData);
      final decrypted = encrypter.decrypt(crypto.Encrypted(data), iv: iv);
      return decrypted;
    } catch (e) {
      throw Exception('Decryption failed: ${e.toString()}');
    }
  }
}
