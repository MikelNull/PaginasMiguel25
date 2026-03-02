import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// AES-256 encryption service for sensitive student data.
///
/// Encrypts: names, matriculas, grades, attendance records.
/// Key is derived from a master password + salt and stored securely.
class EncryptionService {
  static const _keyStorageKey = 'encryption_master_key';
  static const _ivStorageKey = 'encryption_iv';
  static const _saltStorageKey = 'encryption_salt';

  final FlutterSecureStorage _secureStorage;
  encrypt.Key? _key;
  encrypt.IV? _iv;

  EncryptionService({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  /// Initialize encryption with a master password.
  /// Called once during admin setup.
  Future<void> initialize(String masterPassword) async {
    // Generate or retrieve salt
    String? salt = await _secureStorage.read(key: _saltStorageKey);
    if (salt == null) {
      salt = encrypt.Key.fromSecureRandom(16).base64;
      await _secureStorage.write(key: _saltStorageKey, value: salt);
    }

    // Derive key from password + salt using SHA-256
    final keyBytes = sha256
        .convert(utf8.encode('$masterPassword:$salt'))
        .bytes;
    _key = encrypt.Key.fromBase64(base64.encode(keyBytes));

    // Generate or retrieve IV
    String? ivString = await _secureStorage.read(key: _ivStorageKey);
    if (ivString == null) {
      _iv = encrypt.IV.fromSecureRandom(16);
      await _secureStorage.write(key: _ivStorageKey, value: _iv!.base64);
    } else {
      _iv = encrypt.IV.fromBase64(ivString);
    }

    // Store the key securely
    await _secureStorage.write(key: _keyStorageKey, value: _key!.base64);
  }

  /// Load existing key from secure storage.
  Future<bool> loadKey() async {
    final keyString = await _secureStorage.read(key: _keyStorageKey);
    final ivString = await _secureStorage.read(key: _ivStorageKey);

    if (keyString != null && ivString != null) {
      _key = encrypt.Key.fromBase64(keyString);
      _iv = encrypt.IV.fromBase64(ivString);
      return true;
    }
    return false;
  }

  /// Encrypt a plaintext string using AES-256.
  String encryptText(String plainText) {
    if (_key == null || _iv == null) {
      throw StateError('EncryptionService not initialized. Call initialize() or loadKey() first.');
    }

    final encrypter = encrypt.Encrypter(
      encrypt.AES(_key!, mode: encrypt.AESMode.cbc),
    );
    return encrypter.encrypt(plainText, iv: _iv).base64;
  }

  /// Decrypt an encrypted string.
  String decryptText(String encryptedText) {
    if (_key == null || _iv == null) {
      throw StateError('EncryptionService not initialized. Call initialize() or loadKey() first.');
    }

    final encrypter = encrypt.Encrypter(
      encrypt.AES(_key!, mode: encrypt.AESMode.cbc),
    );
    return encrypter.decrypt64(encryptedText, iv: _iv);
  }

  /// Hash a value (for indexing encrypted fields).
  String hashValue(String value) {
    return sha256.convert(utf8.encode(value)).toString();
  }

  /// Check if encryption is initialized.
  bool get isInitialized => _key != null && _iv != null;

  /// Clear all stored keys (for logout/reset).
  Future<void> clearKeys() async {
    await _secureStorage.delete(key: _keyStorageKey);
    await _secureStorage.delete(key: _ivStorageKey);
    await _secureStorage.delete(key: _saltStorageKey);
    _key = null;
    _iv = null;
  }
}
