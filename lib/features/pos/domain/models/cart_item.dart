import 'package:ribaru_v2/features/inventory/domain/models/product.dart';

class CartItem {
  final String id;
  final Product product;
  int quantity;
  double price;
  double get total => price * quantity;

  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.price,
  });

  CartItem copyWith({
    String? id,
    Product? product,
    int? quantity,
    double? price,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': product.id,
      'quantity': quantity,
      'price': price,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map, Product product) {
    return CartItem(
      id: map['id'],
      product: product,
      quantity: map['quantity'],
      price: map['price'],
    );
  }
}
