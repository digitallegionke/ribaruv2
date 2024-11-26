import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ribaru_v2/features/pos/domain/models/order.dart';
import 'package:ribaru_v2/features/pos/domain/models/payment.dart';

class PaymentService {
  static final PaymentService _instance = PaymentService._internal();
  factory PaymentService() => _instance;
  PaymentService._internal();

  static const String _paymentsTable = 'payments';
  static const String _mpesaTransactionsTable = 'mpesa_transactions';
  static const String _splitPaymentsTable = 'split_payments';
  Database? _database;

  Future<void> initialize() async {
    if (_database != null) return;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'payments.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_paymentsTable (
            id TEXT PRIMARY KEY,
            order_id TEXT NOT NULL,
            amount REAL NOT NULL,
            payment_method TEXT NOT NULL,
            status TEXT NOT NULL,
            reference TEXT,
            notes TEXT,
            processed_by TEXT NOT NULL,
            created_at TEXT NOT NULL,
            updated_at TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE $_mpesaTransactionsTable (
            id TEXT PRIMARY KEY,
            payment_id TEXT NOT NULL,
            transaction_id TEXT NOT NULL,
            phone_number TEXT NOT NULL,
            status TEXT NOT NULL,
            message TEXT,
            created_at TEXT NOT NULL,
            FOREIGN KEY (payment_id) REFERENCES $_paymentsTable (id)
          )
        ''');

        await db.execute('''
          CREATE TABLE $_splitPaymentsTable (
            id TEXT PRIMARY KEY,
            payment_id TEXT NOT NULL,
            payment_method TEXT NOT NULL,
            amount REAL NOT NULL,
            status TEXT NOT NULL,
            reference TEXT,
            notes TEXT,
            created_at TEXT NOT NULL,
            FOREIGN KEY (payment_id) REFERENCES $_paymentsTable (id)
          )
        ''');
      },
    );
  }

  Future<bool> processPayment(Order order, String staffId, {
    List<SplitPayment>? splitPayments,
  }) async {
    await initialize();

    try {
      final paymentId = DateTime.now().millisecondsSinceEpoch.toString();
      
      await _database!.transaction((txn) async {
        // Insert main payment record
        await txn.insert(_paymentsTable, {
          'id': paymentId,
          'order_id': order.id,
          'amount': order.total,
          'payment_method': splitPayments != null ? 'split' : order.paymentMethod.name,
          'status': PaymentStatus.completed.name,
          'reference': null,
          'notes': null,
          'processed_by': staffId,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });

        // Handle split payments if present
        if (splitPayments != null) {
          for (final split in splitPayments) {
            await txn.insert(_splitPaymentsTable, {
              'id': split.id,
              'payment_id': paymentId,
              'payment_method': split.paymentMethod,
              'amount': split.amount,
              'status': split.status.name,
              'reference': split.reference,
              'notes': split.notes,
              'created_at': split.createdAt.toIso8601String(),
            });
          }
        }

        // Handle M-PESA transactions if applicable
        if (order.paymentMethod == PaymentMethod.mpesa || 
            (splitPayments?.any((s) => s.paymentMethod == PaymentMethod.mpesa.name) ?? false)) {
          await txn.insert(_mpesaTransactionsTable, {
            'id': DateTime.now().millisecondsSinceEpoch.toString(),
            'payment_id': paymentId,
            'transaction_id': 'MPESA${DateTime.now().millisecondsSinceEpoch}', // Replace with actual M-PESA integration
            'phone_number': order.customerPhone ?? '',
            'status': 'pending',
            'message': null,
            'created_at': DateTime.now().toIso8601String(),
          });
        }
      });

      return true;
    } catch (e) {
      print('Error processing payment: $e');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getPaymentHistory(String orderId) async {
    await initialize();

    final payments = await _database!.query(
      _paymentsTable,
      where: 'order_id = ?',
      whereArgs: [orderId],
    );

    return Future.wait(payments.map((payment) async {
      final splitPayments = await _database!.query(
        _splitPaymentsTable,
        where: 'payment_id = ?',
        whereArgs: [payment['id']],
      );

      final mpesaTransactions = await _database!.query(
        _mpesaTransactionsTable,
        where: 'payment_id = ?',
        whereArgs: [payment['id']],
      );

      return {
        ...payment,
        'split_payments': splitPayments,
        'mpesa_transactions': mpesaTransactions,
      };
    }));
  }

  Future<bool> reconcilePayment(String paymentId, {
    required bool isReconciled,
    String? notes,
  }) async {
    await initialize();

    try {
      await _database!.update(
        _paymentsTable,
        {
          'status': isReconciled ? PaymentStatus.reconciled.name : PaymentStatus.pending.name,
          'notes': notes,
          'updated_at': DateTime.now().toIso8601String(),
        },
        where: 'id = ?',
        whereArgs: [paymentId],
      );

      return true;
    } catch (e) {
      print('Error reconciling payment: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> getPaymentStats({
    DateTime? startDate,
    DateTime? endDate,
    String? staffId,
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

    if (staffId != null) {
      whereClause += ' AND processed_by = ?';
      whereArgs.add(staffId);
    }

    final results = await _database!.rawQuery('''
      SELECT 
        payment_method,
        COUNT(*) as count,
        SUM(amount) as total_amount,
        status,
        COUNT(CASE WHEN status = ? THEN 1 END) as reconciled_count,
        processed_by
      FROM $_paymentsTable
      WHERE $whereClause
      GROUP BY payment_method, status, processed_by
    ''', [PaymentStatus.reconciled.name, ...whereArgs]);

    final stats = <String, dynamic>{
      'total_payments': 0,
      'total_amount': 0.0,
      'reconciled_amount': 0.0,
      'payment_methods': <String, Map<String, dynamic>>{},
      'staff_performance': <String, Map<String, dynamic>>{},
    };

    for (final row in results) {
      final method = row['payment_method'] as String;
      final status = row['status'] as String;
      final count = row['count'] as int;
      final amount = row['total_amount'] as double;
      final staffId = row['processed_by'] as String;

      // Update overall stats
      stats['total_payments'] += count;
      stats['total_amount'] += amount;
      if (status == PaymentStatus.reconciled.name) {
        stats['reconciled_amount'] += amount;
      }

      // Update payment method stats
      if (!stats['payment_methods'].containsKey(method)) {
        stats['payment_methods'][method] = {
          'total_count': 0,
          'total_amount': 0.0,
          'reconciled_count': 0,
          'reconciled_amount': 0.0,
        };
      }

      // Update staff performance stats
      if (!stats['staff_performance'].containsKey(staffId)) {
        stats['staff_performance'][staffId] = {
          'total_transactions': 0,
          'total_amount': 0.0,
          'reconciled_count': 0,
          'payment_methods': <String, int>{},
        };
      }

      final methodStats = stats['payment_methods'][method];
      final staffStats = stats['staff_performance'][staffId];
      
      methodStats['total_count'] += count;
      methodStats['total_amount'] += amount;
      if (status == PaymentStatus.reconciled.name) {
        methodStats['reconciled_count'] += count;
        methodStats['reconciled_amount'] += amount;
      }

      staffStats['total_transactions'] += count;
      staffStats['total_amount'] += amount;
      if (status == PaymentStatus.reconciled.name) {
        staffStats['reconciled_count'] += count;
      }
      
      staffStats['payment_methods'][method] = 
          (staffStats['payment_methods'][method] ?? 0) + count;
    }

    return stats;
  }
}
