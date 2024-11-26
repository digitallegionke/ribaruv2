// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentImpl _$$PaymentImplFromJson(Map<String, dynamic> json) =>
    _$PaymentImpl(
      id: json['id'] as String,
      orderId: json['orderId'] as String,
      amount: (json['amount'] as num).toDouble(),
      paymentMethod: json['paymentMethod'] as String,
      status: $enumDecode(_$PaymentStatusEnumMap, json['status']),
      reference: json['reference'] as String?,
      notes: json['notes'] as String?,
      processedBy: json['processedBy'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      mpesaTransactions: (json['mpesaTransactions'] as List<dynamic>?)
          ?.map((e) => MpesaTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      splitPayments: (json['splitPayments'] as List<dynamic>?)
          ?.map((e) => SplitPayment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PaymentImplToJson(_$PaymentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'amount': instance.amount,
      'paymentMethod': instance.paymentMethod,
      'status': _$PaymentStatusEnumMap[instance.status]!,
      'reference': instance.reference,
      'notes': instance.notes,
      'processedBy': instance.processedBy,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'mpesaTransactions': instance.mpesaTransactions,
      'splitPayments': instance.splitPayments,
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'pending',
  PaymentStatus.completed: 'completed',
  PaymentStatus.failed: 'failed',
  PaymentStatus.reconciled: 'reconciled',
  PaymentStatus.refunded: 'refunded',
};

_$SplitPaymentImpl _$$SplitPaymentImplFromJson(Map<String, dynamic> json) =>
    _$SplitPaymentImpl(
      id: json['id'] as String,
      paymentId: json['paymentId'] as String,
      paymentMethod: json['paymentMethod'] as String,
      amount: (json['amount'] as num).toDouble(),
      status: $enumDecode(_$PaymentStatusEnumMap, json['status']),
      reference: json['reference'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$SplitPaymentImplToJson(_$SplitPaymentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'paymentId': instance.paymentId,
      'paymentMethod': instance.paymentMethod,
      'amount': instance.amount,
      'status': _$PaymentStatusEnumMap[instance.status]!,
      'reference': instance.reference,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$MpesaTransactionImpl _$$MpesaTransactionImplFromJson(
        Map<String, dynamic> json) =>
    _$MpesaTransactionImpl(
      id: json['id'] as String,
      paymentId: json['paymentId'] as String,
      transactionId: json['transactionId'] as String,
      phoneNumber: json['phoneNumber'] as String,
      status: json['status'] as String,
      message: json['message'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$MpesaTransactionImplToJson(
        _$MpesaTransactionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'paymentId': instance.paymentId,
      'transactionId': instance.transactionId,
      'phoneNumber': instance.phoneNumber,
      'status': instance.status,
      'message': instance.message,
      'createdAt': instance.createdAt.toIso8601String(),
    };
