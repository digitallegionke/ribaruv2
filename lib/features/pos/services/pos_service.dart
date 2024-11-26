import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ribaru_v2/features/inventory/services/inventory_service.dart';
import 'package:ribaru_v2/features/pos/domain/models/cart_item.dart';
import 'package:ribaru_v2/features/pos/domain/models/order.dart';

class POSService {
  static final POSService _instance = POSService._internal();
  factory POSService() => _instance;
  POSService._internal();

  static const String _ordersTable = 'orders';
  static const String _orderItemsTable = 'order_items';
  Database? _database;
  final _inventoryService = InventoryService();

  Future<void> initialize() async {
    if (_database != null) return;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'pos.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_ordersTable (
            id TEXT PRIMARY KEY,
            subtotal REAL NOT NULL,
            tax REAL NOT NULL,
            discount REAL NOT NULL,
            total REAL NOT NULL,
            payment_method TEXT NOT NULL,
            status TEXT NOT NULL,
            customer_id TEXT,
            customer_name TEXT,
            customer_phone TEXT,
            notes TEXT,
            created_at TEXT NOT NULL,
            updated_at TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE $_orderItemsTable (
            id TEXT PRIMARY KEY,
            order_id TEXT NOT NULL,
            product_id TEXT NOT NULL,
            quantity INTEGER NOT NULL,
            price REAL NOT NULL,
            FOREIGN KEY (order_id) REFERENCES $_ordersTable (id)
          )
        ''');
      },
    );
  }

  Future<Order> createOrder(Order order) async {
    await initialize();

    await _database!.transaction((txn) async {
      // Insert order
      await txn.insert(_ordersTable, order.toMap());

      // Insert order items
      for (final item in order.items) {
        await txn.insert(_orderItemsTable, {
          'id': item.id,
          'order_id': order.id,
          'product_id': item.product.id,
          'quantity': item.quantity,
          'price': item.price,
        });

        // Update inventory
        await _inventoryService.adjustStock(
          productId: item.product.id,
          quantity: -item.quantity,
          reason: 'Sale: Order ${order.id}',
        );
      }
    });

    return order;
  }

  Future<Order?> getOrder(String id) async {
    await initialize();

    final orderResult = await _database!.query(
      _ordersTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (orderResult.isEmpty) return null;

    final itemsResult = await _database!.query(
      _orderItemsTable,
      where: 'order_id = ?',
      whereArgs: [id],
    );

    final items = await Future.wait(
      itemsResult.map((item) async {
        final product = await _inventoryService.getProduct(item['product_id'] as String);
        if (product == null) throw Exception('Product not found');
        return CartItem.fromMap(item, product);
      }),
    );

    return Order.fromMap(orderResult.first, items);
  }

  Future<List<Order>> getOrders({
    DateTime? startDate,
    DateTime? endDate,
    OrderStatus? status,
    int limit = 50,
    int offset = 0,
  }) async {
    await initialize();

    String whereClause = '1=1';
    List<dynamic> whereArgs = [];

    if (startDate != null) {
      whereClause += ' AND created_at >= ?';
      whereArgs.add(startDate.toIso8601String());
    }

    if (endDate != null) {
      whereClause += ' AND created_at <= ?';
      whereArgs.add(endDate.toIso8601String());
    }

    if (status != null) {
      whereClause += ' AND status = ?';
      whereArgs.add(status.name);
    }

    final orderResults = await _database!.query(
      _ordersTable,
      where: whereClause,
      whereArgs: whereArgs,
      orderBy: 'created_at DESC',
      limit: limit,
      offset: offset,
    );

    return Future.wait(
      orderResults.map((order) async {
        final itemsResult = await _database!.query(
          _orderItemsTable,
          where: 'order_id = ?',
          whereArgs: [order['id']],
        );

        final items = await Future.wait(
          itemsResult.map((item) async {
            final product = await _inventoryService.getProduct(item['product_id'] as String);
            if (product == null) throw Exception('Product not found');
            return CartItem.fromMap(item, product);
          }),
        );

        return Order.fromMap(order, items);
      }),
    );
  }

  Future<bool> updateOrderStatus(String orderId, OrderStatus status) async {
    await initialize();

    final result = await _database!.update(
      _ordersTable,
      {
        'status': status.name,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [orderId],
    );

    return result > 0;
  }

  Future<bool> refundOrder(String orderId) async {
    await initialize();

    final order = await getOrder(orderId);
    if (order == null) return false;

    await _database!.transaction((txn) async {
      // Update order status
      await txn.update(
        _ordersTable,
        {
          'status': OrderStatus.refunded.name,
          'updated_at': DateTime.now().toIso8601String(),
        },
        where: 'id = ?',
        whereArgs: [orderId],
      );

      // Return items to inventory
      for (final item in order.items) {
        await _inventoryService.adjustStock(
          productId: item.product.id,
          quantity: item.quantity,
          reason: 'Refund: Order $orderId',
        );
      }
    });

    return true;
  }
}
