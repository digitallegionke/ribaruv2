import 'package:ribaru_v2/features/pos/domain/models/cart_item.dart';

enum PaymentMethod {
  cash,
  mpesa,
  card,
  other,
}

enum OrderStatus {
  pending,
  completed,
  cancelled,
  refunded,
}

class Order {
  final String id;
  final List<CartItem> items;
  final double subtotal;
  final double tax;
  final double discount;
  final double total;
  final PaymentMethod paymentMethod;
  final OrderStatus status;
  final String? customerId;
  final String? customerName;
  final String? customerPhone;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Order({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.discount,
    required this.total,
    required this.paymentMethod,
    required this.status,
    this.customerId,
    this.customerName,
    this.customerPhone,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  Order copyWith({
    String? id,
    List<CartItem>? items,
    double? subtotal,
    double? tax,
    double? discount,
    double? total,
    PaymentMethod? paymentMethod,
    OrderStatus? status,
    String? customerId,
    String? customerName,
    String? customerPhone,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Order(
      id: id ?? this.id,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      tax: tax ?? this.tax,
      discount: discount ?? this.discount,
      total: total ?? this.total,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subtotal': subtotal,
      'tax': tax,
      'discount': discount,
      'total': total,
      'payment_method': paymentMethod.name,
      'status': status.name,
      'customer_id': customerId,
      'customer_name': customerName,
      'customer_phone': customerPhone,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map, List<CartItem> items) {
    return Order(
      id: map['id'],
      items: items,
      subtotal: map['subtotal'],
      tax: map['tax'],
      discount: map['discount'],
      total: map['total'],
      paymentMethod: PaymentMethod.values.firstWhere(
        (e) => e.name == map['payment_method'],
        orElse: () => PaymentMethod.other,
      ),
      status: OrderStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => OrderStatus.pending,
      ),
      customerId: map['customer_id'],
      customerName: map['customer_name'],
      customerPhone: map['customer_phone'],
      notes: map['notes'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }
}
