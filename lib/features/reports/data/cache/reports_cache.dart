import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ribaru_v2/features/reports/domain/models/report_data.dart';

class ReportsCache {
  static const String _salesBox = 'sales_reports';
  static const String _inventoryBox = 'inventory_reports';
  static const String _financialBox = 'financial_reports';
  static const String _analyticsBox = 'analytics_reports';

  static const int _maxCacheSize = 50 * 1024 * 1024; // 50 MB
  static const Duration _defaultMaxAge = Duration(hours: 24);

  static Future<void> initialize() async {
    await Hive.initFlutter();
    await Future.wait([
      Hive.openBox(_salesBox),
      Hive.openBox(_inventoryBox),
      Hive.openBox(_financialBox),
      Hive.openBox(_analyticsBox),
    ]);
  }

  Future<void> cacheSalesReport(
    DateTime startDate,
    DateTime endDate,
    SalesReport report,
  ) async {
    final box = Hive.box(_salesBox);
    final key = _generateKey(startDate, endDate);
    await box.put(key, jsonEncode(report.toJson()));
    await box.put('${key}_timestamp', DateTime.now().toIso8601String());
  }

  Future<SalesReport?> getCachedSalesReport(
    DateTime startDate,
    DateTime endDate, {
    Duration maxAge = const Duration(minutes: 15),
  }) async {
    final box = Hive.box(_salesBox);
    final key = _generateKey(startDate, endDate);
    final data = box.get(key);
    final timestamp = box.get('${key}_timestamp');

    if (data != null && timestamp != null) {
      final cacheAge = DateTime.now().difference(DateTime.parse(timestamp));
      if (cacheAge <= maxAge) {
        return SalesReport.fromJson(jsonDecode(data));
      }
    }
    return null;
  }

  Future<void> cacheInventoryReport(InventoryReport report) async {
    final box = Hive.box(_inventoryBox);
    await box.put('latest', jsonEncode(report.toJson()));
    await box.put('timestamp', DateTime.now().toIso8601String());
  }

  Future<InventoryReport?> getCachedInventoryReport({
    Duration maxAge = const Duration(minutes: 5),
  }) async {
    final box = Hive.box(_inventoryBox);
    final data = box.get('latest');
    final timestamp = box.get('timestamp');

    if (data != null && timestamp != null) {
      final cacheAge = DateTime.now().difference(DateTime.parse(timestamp));
      if (cacheAge <= maxAge) {
        return InventoryReport.fromJson(jsonDecode(data));
      }
    }
    return null;
  }

  Future<void> cacheFinancialSummary(
    DateTime startDate,
    DateTime endDate,
    FinancialSummary summary,
  ) async {
    final box = Hive.box(_financialBox);
    final key = _generateKey(startDate, endDate);
    await box.put(key, jsonEncode(summary.toJson()));
    await box.put('${key}_timestamp', DateTime.now().toIso8601String());
  }

  Future<FinancialSummary?> getCachedFinancialSummary(
    DateTime startDate,
    DateTime endDate, {
    Duration maxAge = const Duration(hours: 1),
  }) async {
    final box = Hive.box(_financialBox);
    final key = _generateKey(startDate, endDate);
    final data = box.get(key);
    final timestamp = box.get('${key}_timestamp');

    if (data != null && timestamp != null) {
      final cacheAge = DateTime.now().difference(DateTime.parse(timestamp));
      if (cacheAge <= maxAge) {
        return FinancialSummary.fromJson(jsonDecode(data));
      }
    }
    return null;
  }

  Future<void> cacheAnalyticsSummary(
    DateTime startDate,
    DateTime endDate,
    AnalyticsSummary summary,
  ) async {
    final box = Hive.box(_analyticsBox);
    final key = _generateKey(startDate, endDate);
    await box.put(key, jsonEncode(summary.toJson()));
    await box.put('${key}_timestamp', DateTime.now().toIso8601String());
  }

  Future<AnalyticsSummary?> getCachedAnalyticsSummary(
    DateTime startDate,
    DateTime endDate, {
    Duration maxAge = const Duration(hours: 6),
  }) async {
    final box = Hive.box(_analyticsBox);
    final key = _generateKey(startDate, endDate);
    final data = box.get(key);
    final timestamp = box.get('${key}_timestamp');

    if (data != null && timestamp != null) {
      final cacheAge = DateTime.now().difference(DateTime.parse(timestamp));
      if (cacheAge <= maxAge) {
        return AnalyticsSummary.fromJson(jsonDecode(data));
      }
    }
    return null;
  }

  Future<void> clearCache() async {
    await Future.wait([
      Hive.box(_salesBox).clear(),
      Hive.box(_inventoryBox).clear(),
      Hive.box(_financialBox).clear(),
      Hive.box(_analyticsBox).clear(),
    ]);
  }

  Future<void> cleanupCache() async {
    final boxes = [_salesBox, _inventoryBox, _financialBox, _analyticsBox];
    
    for (final boxName in boxes) {
      final box = Hive.box(boxName);
      final keys = box.keys.toList();
      
      // Remove expired entries
      for (final key in keys) {
        if (key.toString().endsWith('_timestamp')) continue;
        
        final timestamp = box.get('${key}_timestamp');
        if (timestamp == null) continue;
        
        final cacheAge = DateTime.now().difference(DateTime.parse(timestamp));
        if (cacheAge > _defaultMaxAge) {
          await box.delete(key);
          await box.delete('${key}_timestamp');
        }
      }
      
      // Check cache size
      await _manageCacheSize(box);
    }
  }

  Future<void> _manageCacheSize(Box box) async {
    int totalSize = 0;
    final entries = <MapEntry<dynamic, int>>[];
    
    // Calculate size of each entry
    for (final key in box.keys) {
      if (key.toString().endsWith('_timestamp')) continue;
      
      final value = box.get(key);
      if (value == null) continue;
      
      final size = value.toString().length;
      totalSize += size;
      entries.add(MapEntry(key, size));
    }
    
    // If total size exceeds limit, remove oldest entries
    if (totalSize > _maxCacheSize) {
      // Sort by timestamp (oldest first)
      entries.sort((a, b) {
        final aTime = DateTime.parse(box.get('${a.key}_timestamp') ?? '');
        final bTime = DateTime.parse(box.get('${b.key}_timestamp') ?? '');
        return aTime.compareTo(bTime);
      });
      
      // Remove oldest entries until we're under the limit
      for (final entry in entries) {
        if (totalSize <= _maxCacheSize) break;
        
        await box.delete(entry.key);
        await box.delete('${entry.key}_timestamp');
        totalSize -= entry.value;
      }
    }
  }

  Future<void> invalidateCache() async {
    final boxes = [_salesBox, _inventoryBox, _financialBox, _analyticsBox];
    for (final boxName in boxes) {
      final box = Hive.box(boxName);
      await box.clear();
    }
  }

  Future<CacheStats> getCacheStats() async {
    int totalEntries = 0;
    int totalSize = 0;
    final stats = <String, BoxStats>{};
    
    final boxes = [_salesBox, _inventoryBox, _financialBox, _analyticsBox];
    for (final boxName in boxes) {
      final box = Hive.box(boxName);
      final entries = box.keys.where((k) => !k.toString().endsWith('_timestamp')).length;
      final size = box.values.fold<int>(0, (sum, item) => sum + (item?.toString().length ?? 0));
      
      totalEntries += entries;
      totalSize += size;
      
      stats[boxName] = BoxStats(
        entries: entries,
        size: size,
        oldestEntry: _getOldestEntryAge(box),
        newestEntry: _getNewestEntryAge(box),
      );
    }
    
    return CacheStats(
      totalEntries: totalEntries,
      totalSize: totalSize,
      boxStats: stats,
    );
  }

  Duration? _getOldestEntryAge(Box box) {
    DateTime? oldest;
    for (final key in box.keys) {
      if (key.toString().endsWith('_timestamp')) continue;
      final timestamp = box.get('${key}_timestamp');
      if (timestamp == null) continue;
      
      final date = DateTime.parse(timestamp);
      if (oldest == null || date.isBefore(oldest)) {
        oldest = date;
      }
    }
    return oldest != null ? DateTime.now().difference(oldest) : null;
  }

  Duration? _getNewestEntryAge(Box box) {
    DateTime? newest;
    for (final key in box.keys) {
      if (key.toString().endsWith('_timestamp')) continue;
      final timestamp = box.get('${key}_timestamp');
      if (timestamp == null) continue;
      
      final date = DateTime.parse(timestamp);
      if (newest == null || date.isAfter(newest)) {
        newest = date;
      }
    }
    return newest != null ? DateTime.now().difference(newest) : null;
  }

  String _generateKey(DateTime startDate, DateTime endDate) {
    return '${startDate.toIso8601String()}_${endDate.toIso8601String()}';
  }
}

class CacheStats {
  final int totalEntries;
  final int totalSize;
  final Map<String, BoxStats> boxStats;

  CacheStats({
    required this.totalEntries,
    required this.totalSize,
    required this.boxStats,
  });
}

class BoxStats {
  final int entries;
  final int size;
  final Duration? oldestEntry;
  final Duration? newestEntry;

  BoxStats({
    required this.entries,
    required this.size,
    this.oldestEntry,
    this.newestEntry,
  });
}
