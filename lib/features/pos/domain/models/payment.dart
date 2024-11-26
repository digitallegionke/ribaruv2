import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

enum PaymentStatus {
  pending,
  completed,
  failed,
  reconciled,
  refunded,
}

@freezed
class Payment with _$Payment {
  const factory Payment({
    required String id,
    required String orderId,
    required double amount,
    required String paymentMethod,
    required PaymentStatus status,
    String? reference,
    String? notes,
    required String processedBy, // Staff member ID who processed the payment
    required DateTime createdAt,
    required DateTime updatedAt,
    List<MpesaTransaction>? mpesaTransactions,
    List<SplitPayment>? splitPayments,
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);
}

@freezed
class SplitPayment with _$SplitPayment {
  const factory SplitPayment({
    required String id,
    required String paymentId,
    required String paymentMethod,
    required double amount,
    required PaymentStatus status,
    String? reference,
    String? notes,
    required DateTime createdAt,
  }) = _SplitPayment;

  factory SplitPayment.fromJson(Map<String, dynamic> json) =>
      _$SplitPaymentFromJson(json);
}

@freezed
class MpesaTransaction with _$MpesaTransaction {
  const factory MpesaTransaction({
    required String id,
    required String paymentId,
    required String transactionId,
    required String phoneNumber,
    required String status,
    String? message,
    required DateTime createdAt,
  }) = _MpesaTransaction;

  factory MpesaTransaction.fromJson(Map<String, dynamic> json) =>
      _$MpesaTransactionFromJson(json);
}
