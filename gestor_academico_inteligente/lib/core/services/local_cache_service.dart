import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

/// Local cache service using Hive for reducing Firestore reads.
/// Reduces Firestore reads by ~70% as per optimization strategy.
class LocalCacheService {
  static const String _attendanceCacheBox = 'attendance_cache';
  static const String _evaluationCacheBox = 'evaluation_cache';
  static const String _rubricCacheBox = 'rubric_cache';
  static const String _reportCacheBox = 'report_cache';
  static const String _userCacheBox = 'user_cache';

  /// Initialize Hive and open all cache boxes.
  Future<void> initialize() async {
    await Hive.initFlutter();
    await Future.wait([
      Hive.openBox(_attendanceCacheBox),
      Hive.openBox(_evaluationCacheBox),
      Hive.openBox(_rubricCacheBox),
      Hive.openBox(_reportCacheBox),
      Hive.openBox(_userCacheBox),
    ]);
  }

  /// Store data in cache with a TTL.
  Future<void> put(String boxName, String key, dynamic value,
      {Duration? ttl}) async {
    final box = Hive.box(boxName);
    final cacheEntry = {
      'data': value is String ? value : jsonEncode(value),
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'ttl': ttl?.inMilliseconds,
    };
    await box.put(key, cacheEntry);
  }

  /// Get data from cache, returns null if expired or not found.
  dynamic get(String boxName, String key) {
    final box = Hive.box(boxName);
    final cacheEntry = box.get(key);

    if (cacheEntry == null) return null;

    final entry = Map<String, dynamic>.from(cacheEntry);
    final timestamp = entry['timestamp'] as int;
    final ttl = entry['ttl'] as int?;

    if (ttl != null) {
      final expiresAt = DateTime.fromMillisecondsSinceEpoch(timestamp + ttl);
      if (DateTime.now().isAfter(expiresAt)) {
        box.delete(key);
        return null;
      }
    }

    return entry['data'];
  }

  /// Remove a specific cache entry.
  Future<void> remove(String boxName, String key) async {
    final box = Hive.box(boxName);
    await box.delete(key);
  }

  /// Clear all cached data for a specific box.
  Future<void> clearBox(String boxName) async {
    final box = Hive.box(boxName);
    await box.clear();
  }

  /// Clear all caches.
  Future<void> clearAll() async {
    await Future.wait([
      clearBox(_attendanceCacheBox),
      clearBox(_evaluationCacheBox),
      clearBox(_rubricCacheBox),
      clearBox(_reportCacheBox),
      clearBox(_userCacheBox),
    ]);
  }

  // Convenience methods for specific cache types
  static String get attendanceBox => _attendanceCacheBox;
  static String get evaluationBox => _evaluationCacheBox;
  static String get rubricBox => _rubricCacheBox;
  static String get reportBox => _reportCacheBox;
  static String get userBox => _userCacheBox;
}
