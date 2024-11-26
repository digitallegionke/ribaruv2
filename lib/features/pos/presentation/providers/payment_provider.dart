import 'package:flutter/foundation.dart';
import 'package:ribaru_v2/features/pos/domain/models/order.dart';
import 'package:ribaru_v2/features/pos/domain/models/payment.dart';
import 'package:ribaru_v2/features/pos/services/payment_service.dart';

class PaymentProvider extends ChangeNotifier {
  final PaymentService _paymentService = PaymentService();
  bool _isProcessing = false;
  String? _error;

  bool get isProcessing => _isProcessing;
  String? get error => _error;

  Future<bool> processPayment(
    Order order,
    String staffId, {
    List<SplitPayment>? splitPayments,
  }) async {
    try {
      _isProcessing = true;
      _error = null;
      notifyListeners();

      final success = await _paymentService.processPayment(
        order,
        staffId,
        splitPayments: splitPayments,
      );

      _isProcessing = false;
      if (!success) {
        _error = 'Failed to process payment';
      }
      notifyListeners();

      return success;
    } catch (e) {
      _isProcessing = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getPaymentHistory(String orderId) async {
    try {
      _error = null;
      notifyListeners();

      final history = await _paymentService.getPaymentHistory(orderId);
      return history;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return [];
    }
  }

  Future<Map<String, dynamic>> getPaymentStats({
    DateTime? startDate,
    DateTime? endDate,
    String? staffId,
  }) async {
    try {
      _error = null;
      notifyListeners();

      final stats = await _paymentService.getPaymentStats(
        startDate: startDate,
        endDate: endDate,
        staffId: staffId,
      );
      return stats;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return {};
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
