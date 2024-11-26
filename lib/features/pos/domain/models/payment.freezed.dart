// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Payment _$PaymentFromJson(Map<String, dynamic> json) {
  return _Payment.fromJson(json);
}

/// @nodoc
mixin _$Payment {
  String get id => throw _privateConstructorUsedError;
  String get orderId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get paymentMethod => throw _privateConstructorUsedError;
  PaymentStatus get status => throw _privateConstructorUsedError;
  String? get reference => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String get processedBy =>
      throw _privateConstructorUsedError; // Staff member ID who processed the payment
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  List<MpesaTransaction>? get mpesaTransactions =>
      throw _privateConstructorUsedError;
  List<SplitPayment>? get splitPayments => throw _privateConstructorUsedError;

  /// Serializes this Payment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentCopyWith<Payment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentCopyWith<$Res> {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) then) =
      _$PaymentCopyWithImpl<$Res, Payment>;
  @useResult
  $Res call(
      {String id,
      String orderId,
      double amount,
      String paymentMethod,
      PaymentStatus status,
      String? reference,
      String? notes,
      String processedBy,
      DateTime createdAt,
      DateTime updatedAt,
      List<MpesaTransaction>? mpesaTransactions,
      List<SplitPayment>? splitPayments});
}

/// @nodoc
class _$PaymentCopyWithImpl<$Res, $Val extends Payment>
    implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderId = null,
    Object? amount = null,
    Object? paymentMethod = null,
    Object? status = null,
    Object? reference = freezed,
    Object? notes = freezed,
    Object? processedBy = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? mpesaTransactions = freezed,
    Object? splitPayments = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PaymentStatus,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      processedBy: null == processedBy
          ? _value.processedBy
          : processedBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mpesaTransactions: freezed == mpesaTransactions
          ? _value.mpesaTransactions
          : mpesaTransactions // ignore: cast_nullable_to_non_nullable
              as List<MpesaTransaction>?,
      splitPayments: freezed == splitPayments
          ? _value.splitPayments
          : splitPayments // ignore: cast_nullable_to_non_nullable
              as List<SplitPayment>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentImplCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$$PaymentImplCopyWith(
          _$PaymentImpl value, $Res Function(_$PaymentImpl) then) =
      __$$PaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String orderId,
      double amount,
      String paymentMethod,
      PaymentStatus status,
      String? reference,
      String? notes,
      String processedBy,
      DateTime createdAt,
      DateTime updatedAt,
      List<MpesaTransaction>? mpesaTransactions,
      List<SplitPayment>? splitPayments});
}

/// @nodoc
class __$$PaymentImplCopyWithImpl<$Res>
    extends _$PaymentCopyWithImpl<$Res, _$PaymentImpl>
    implements _$$PaymentImplCopyWith<$Res> {
  __$$PaymentImplCopyWithImpl(
      _$PaymentImpl _value, $Res Function(_$PaymentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderId = null,
    Object? amount = null,
    Object? paymentMethod = null,
    Object? status = null,
    Object? reference = freezed,
    Object? notes = freezed,
    Object? processedBy = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? mpesaTransactions = freezed,
    Object? splitPayments = freezed,
  }) {
    return _then(_$PaymentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PaymentStatus,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      processedBy: null == processedBy
          ? _value.processedBy
          : processedBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mpesaTransactions: freezed == mpesaTransactions
          ? _value._mpesaTransactions
          : mpesaTransactions // ignore: cast_nullable_to_non_nullable
              as List<MpesaTransaction>?,
      splitPayments: freezed == splitPayments
          ? _value._splitPayments
          : splitPayments // ignore: cast_nullable_to_non_nullable
              as List<SplitPayment>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentImpl implements _Payment {
  const _$PaymentImpl(
      {required this.id,
      required this.orderId,
      required this.amount,
      required this.paymentMethod,
      required this.status,
      this.reference,
      this.notes,
      required this.processedBy,
      required this.createdAt,
      required this.updatedAt,
      final List<MpesaTransaction>? mpesaTransactions,
      final List<SplitPayment>? splitPayments})
      : _mpesaTransactions = mpesaTransactions,
        _splitPayments = splitPayments;

  factory _$PaymentImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentImplFromJson(json);

  @override
  final String id;
  @override
  final String orderId;
  @override
  final double amount;
  @override
  final String paymentMethod;
  @override
  final PaymentStatus status;
  @override
  final String? reference;
  @override
  final String? notes;
  @override
  final String processedBy;
// Staff member ID who processed the payment
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  final List<MpesaTransaction>? _mpesaTransactions;
  @override
  List<MpesaTransaction>? get mpesaTransactions {
    final value = _mpesaTransactions;
    if (value == null) return null;
    if (_mpesaTransactions is EqualUnmodifiableListView)
      return _mpesaTransactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<SplitPayment>? _splitPayments;
  @override
  List<SplitPayment>? get splitPayments {
    final value = _splitPayments;
    if (value == null) return null;
    if (_splitPayments is EqualUnmodifiableListView) return _splitPayments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Payment(id: $id, orderId: $orderId, amount: $amount, paymentMethod: $paymentMethod, status: $status, reference: $reference, notes: $notes, processedBy: $processedBy, createdAt: $createdAt, updatedAt: $updatedAt, mpesaTransactions: $mpesaTransactions, splitPayments: $splitPayments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.processedBy, processedBy) ||
                other.processedBy == processedBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality()
                .equals(other._mpesaTransactions, _mpesaTransactions) &&
            const DeepCollectionEquality()
                .equals(other._splitPayments, _splitPayments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      orderId,
      amount,
      paymentMethod,
      status,
      reference,
      notes,
      processedBy,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_mpesaTransactions),
      const DeepCollectionEquality().hash(_splitPayments));

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentImplCopyWith<_$PaymentImpl> get copyWith =>
      __$$PaymentImplCopyWithImpl<_$PaymentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentImplToJson(
      this,
    );
  }
}

abstract class _Payment implements Payment {
  const factory _Payment(
      {required final String id,
      required final String orderId,
      required final double amount,
      required final String paymentMethod,
      required final PaymentStatus status,
      final String? reference,
      final String? notes,
      required final String processedBy,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final List<MpesaTransaction>? mpesaTransactions,
      final List<SplitPayment>? splitPayments}) = _$PaymentImpl;

  factory _Payment.fromJson(Map<String, dynamic> json) = _$PaymentImpl.fromJson;

  @override
  String get id;
  @override
  String get orderId;
  @override
  double get amount;
  @override
  String get paymentMethod;
  @override
  PaymentStatus get status;
  @override
  String? get reference;
  @override
  String? get notes;
  @override
  String get processedBy; // Staff member ID who processed the payment
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  List<MpesaTransaction>? get mpesaTransactions;
  @override
  List<SplitPayment>? get splitPayments;

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentImplCopyWith<_$PaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SplitPayment _$SplitPaymentFromJson(Map<String, dynamic> json) {
  return _SplitPayment.fromJson(json);
}

/// @nodoc
mixin _$SplitPayment {
  String get id => throw _privateConstructorUsedError;
  String get paymentId => throw _privateConstructorUsedError;
  String get paymentMethod => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  PaymentStatus get status => throw _privateConstructorUsedError;
  String? get reference => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this SplitPayment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SplitPayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SplitPaymentCopyWith<SplitPayment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SplitPaymentCopyWith<$Res> {
  factory $SplitPaymentCopyWith(
          SplitPayment value, $Res Function(SplitPayment) then) =
      _$SplitPaymentCopyWithImpl<$Res, SplitPayment>;
  @useResult
  $Res call(
      {String id,
      String paymentId,
      String paymentMethod,
      double amount,
      PaymentStatus status,
      String? reference,
      String? notes,
      DateTime createdAt});
}

/// @nodoc
class _$SplitPaymentCopyWithImpl<$Res, $Val extends SplitPayment>
    implements $SplitPaymentCopyWith<$Res> {
  _$SplitPaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SplitPayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? paymentId = null,
    Object? paymentMethod = null,
    Object? amount = null,
    Object? status = null,
    Object? reference = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      paymentId: null == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PaymentStatus,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SplitPaymentImplCopyWith<$Res>
    implements $SplitPaymentCopyWith<$Res> {
  factory _$$SplitPaymentImplCopyWith(
          _$SplitPaymentImpl value, $Res Function(_$SplitPaymentImpl) then) =
      __$$SplitPaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String paymentId,
      String paymentMethod,
      double amount,
      PaymentStatus status,
      String? reference,
      String? notes,
      DateTime createdAt});
}

/// @nodoc
class __$$SplitPaymentImplCopyWithImpl<$Res>
    extends _$SplitPaymentCopyWithImpl<$Res, _$SplitPaymentImpl>
    implements _$$SplitPaymentImplCopyWith<$Res> {
  __$$SplitPaymentImplCopyWithImpl(
      _$SplitPaymentImpl _value, $Res Function(_$SplitPaymentImpl) _then)
      : super(_value, _then);

  /// Create a copy of SplitPayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? paymentId = null,
    Object? paymentMethod = null,
    Object? amount = null,
    Object? status = null,
    Object? reference = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$SplitPaymentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      paymentId: null == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PaymentStatus,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SplitPaymentImpl implements _SplitPayment {
  const _$SplitPaymentImpl(
      {required this.id,
      required this.paymentId,
      required this.paymentMethod,
      required this.amount,
      required this.status,
      this.reference,
      this.notes,
      required this.createdAt});

  factory _$SplitPaymentImpl.fromJson(Map<String, dynamic> json) =>
      _$$SplitPaymentImplFromJson(json);

  @override
  final String id;
  @override
  final String paymentId;
  @override
  final String paymentMethod;
  @override
  final double amount;
  @override
  final PaymentStatus status;
  @override
  final String? reference;
  @override
  final String? notes;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'SplitPayment(id: $id, paymentId: $paymentId, paymentMethod: $paymentMethod, amount: $amount, status: $status, reference: $reference, notes: $notes, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SplitPaymentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, paymentId, paymentMethod,
      amount, status, reference, notes, createdAt);

  /// Create a copy of SplitPayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SplitPaymentImplCopyWith<_$SplitPaymentImpl> get copyWith =>
      __$$SplitPaymentImplCopyWithImpl<_$SplitPaymentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SplitPaymentImplToJson(
      this,
    );
  }
}

abstract class _SplitPayment implements SplitPayment {
  const factory _SplitPayment(
      {required final String id,
      required final String paymentId,
      required final String paymentMethod,
      required final double amount,
      required final PaymentStatus status,
      final String? reference,
      final String? notes,
      required final DateTime createdAt}) = _$SplitPaymentImpl;

  factory _SplitPayment.fromJson(Map<String, dynamic> json) =
      _$SplitPaymentImpl.fromJson;

  @override
  String get id;
  @override
  String get paymentId;
  @override
  String get paymentMethod;
  @override
  double get amount;
  @override
  PaymentStatus get status;
  @override
  String? get reference;
  @override
  String? get notes;
  @override
  DateTime get createdAt;

  /// Create a copy of SplitPayment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SplitPaymentImplCopyWith<_$SplitPaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MpesaTransaction _$MpesaTransactionFromJson(Map<String, dynamic> json) {
  return _MpesaTransaction.fromJson(json);
}

/// @nodoc
mixin _$MpesaTransaction {
  String get id => throw _privateConstructorUsedError;
  String get paymentId => throw _privateConstructorUsedError;
  String get transactionId => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this MpesaTransaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MpesaTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MpesaTransactionCopyWith<MpesaTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MpesaTransactionCopyWith<$Res> {
  factory $MpesaTransactionCopyWith(
          MpesaTransaction value, $Res Function(MpesaTransaction) then) =
      _$MpesaTransactionCopyWithImpl<$Res, MpesaTransaction>;
  @useResult
  $Res call(
      {String id,
      String paymentId,
      String transactionId,
      String phoneNumber,
      String status,
      String? message,
      DateTime createdAt});
}

/// @nodoc
class _$MpesaTransactionCopyWithImpl<$Res, $Val extends MpesaTransaction>
    implements $MpesaTransactionCopyWith<$Res> {
  _$MpesaTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MpesaTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? paymentId = null,
    Object? transactionId = null,
    Object? phoneNumber = null,
    Object? status = null,
    Object? message = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      paymentId: null == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MpesaTransactionImplCopyWith<$Res>
    implements $MpesaTransactionCopyWith<$Res> {
  factory _$$MpesaTransactionImplCopyWith(_$MpesaTransactionImpl value,
          $Res Function(_$MpesaTransactionImpl) then) =
      __$$MpesaTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String paymentId,
      String transactionId,
      String phoneNumber,
      String status,
      String? message,
      DateTime createdAt});
}

/// @nodoc
class __$$MpesaTransactionImplCopyWithImpl<$Res>
    extends _$MpesaTransactionCopyWithImpl<$Res, _$MpesaTransactionImpl>
    implements _$$MpesaTransactionImplCopyWith<$Res> {
  __$$MpesaTransactionImplCopyWithImpl(_$MpesaTransactionImpl _value,
      $Res Function(_$MpesaTransactionImpl) _then)
      : super(_value, _then);

  /// Create a copy of MpesaTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? paymentId = null,
    Object? transactionId = null,
    Object? phoneNumber = null,
    Object? status = null,
    Object? message = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$MpesaTransactionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      paymentId: null == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MpesaTransactionImpl implements _MpesaTransaction {
  const _$MpesaTransactionImpl(
      {required this.id,
      required this.paymentId,
      required this.transactionId,
      required this.phoneNumber,
      required this.status,
      this.message,
      required this.createdAt});

  factory _$MpesaTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$MpesaTransactionImplFromJson(json);

  @override
  final String id;
  @override
  final String paymentId;
  @override
  final String transactionId;
  @override
  final String phoneNumber;
  @override
  final String status;
  @override
  final String? message;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'MpesaTransaction(id: $id, paymentId: $paymentId, transactionId: $transactionId, phoneNumber: $phoneNumber, status: $status, message: $message, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MpesaTransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, paymentId, transactionId,
      phoneNumber, status, message, createdAt);

  /// Create a copy of MpesaTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MpesaTransactionImplCopyWith<_$MpesaTransactionImpl> get copyWith =>
      __$$MpesaTransactionImplCopyWithImpl<_$MpesaTransactionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MpesaTransactionImplToJson(
      this,
    );
  }
}

abstract class _MpesaTransaction implements MpesaTransaction {
  const factory _MpesaTransaction(
      {required final String id,
      required final String paymentId,
      required final String transactionId,
      required final String phoneNumber,
      required final String status,
      final String? message,
      required final DateTime createdAt}) = _$MpesaTransactionImpl;

  factory _MpesaTransaction.fromJson(Map<String, dynamic> json) =
      _$MpesaTransactionImpl.fromJson;

  @override
  String get id;
  @override
  String get paymentId;
  @override
  String get transactionId;
  @override
  String get phoneNumber;
  @override
  String get status;
  @override
  String? get message;
  @override
  DateTime get createdAt;

  /// Create a copy of MpesaTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MpesaTransactionImplCopyWith<_$MpesaTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
