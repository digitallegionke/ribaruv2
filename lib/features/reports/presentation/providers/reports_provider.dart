import 'package:flutter/foundation.dart';
import 'package:ribaru_v2/features/reports/data/repositories/reports_repository.dart';
import 'package:ribaru_v2/features/reports/domain/models/report_data.dart';

class ReportsProvider extends ChangeNotifier {
  final ReportsRepository _repository;

  ReportsProvider(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  // Sales Report
  SalesReport? _salesReport;
  SalesReport? get salesReport => _salesReport;

  // Inventory Report
  InventoryReport? _inventoryReport;
  InventoryReport? get inventoryReport => _inventoryReport;

  // Financial Summary
  FinancialSummary? _financialSummary;
  FinancialSummary? get financialSummary => _financialSummary;

  // Analytics Summary
  AnalyticsSummary? _analyticsSummary;
  AnalyticsSummary? get analyticsSummary => _analyticsSummary;

  Future<void> loadSalesReport({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    _setLoading(true);
    try {
      _salesReport = await _repository.getSalesReport(
        startDate: startDate,
        endDate: endDate,
      );
      _error = null;
    } catch (e) {
      _error = 'Failed to load sales report: ${e.toString()}';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadInventoryReport() async {
    _setLoading(true);
    try {
      _inventoryReport = await _repository.getInventoryReport();
      _error = null;
    } catch (e) {
      _error = 'Failed to load inventory report: ${e.toString()}';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadFinancialSummary({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    _setLoading(true);
    try {
      _financialSummary = await _repository.getFinancialSummary(
        startDate: startDate,
        endDate: endDate,
      );
      _error = null;
    } catch (e) {
      _error = 'Failed to load financial summary: ${e.toString()}';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadAnalyticsSummary({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    _setLoading(true);
    try {
      _analyticsSummary = await _repository.getAnalyticsSummary(
        startDate: startDate,
        endDate: endDate,
      );
      _error = null;
    } catch (e) {
      _error = 'Failed to load analytics summary: ${e.toString()}';
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
