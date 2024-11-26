import 'package:ribaru_v2/core/database/database_helper.dart';
import 'package:ribaru_v2/features/reports/domain/models/report_data.dart';

class ReportsRepository {
  final DatabaseHelper _databaseHelper;

  ReportsRepository(this._databaseHelper);

  Future<SalesReport> getSalesReport({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final db = await _databaseHelper.database;

    // Get total sales and orders
    final salesResult = await db.rawQuery('''
      SELECT 
        COUNT(*) as total_orders,
        SUM(total_amount) as total_sales,
        SUM(tax_amount) as total_tax,
        SUM(discount_amount) as total_discount
      FROM orders
      WHERE created_at BETWEEN ? AND ?
    ''', [startDate.toIso8601String(), endDate.toIso8601String()]);

    final totalOrders = salesResult.first['total_orders'] as int? ?? 0;
    final totalSales = salesResult.first['total_sales'] as double? ?? 0.0;
    final totalTax = salesResult.first['total_tax'] as double? ?? 0.0;
    final totalDiscount = salesResult.first['total_discount'] as double? ?? 0.0;

    // Get top selling products
    final topProducts = await db.rawQuery('''
      SELECT 
        p.id as product_id,
        p.name as product_name,
        SUM(oi.quantity) as total_quantity,
        SUM(oi.total_amount) as total_amount,
        AVG(oi.unit_price) as average_price
      FROM order_items oi
      JOIN products p ON p.id = oi.product_id
      JOIN orders o ON o.id = oi.order_id
      WHERE o.created_at BETWEEN ? AND ?
      GROUP BY p.id
      ORDER BY total_quantity DESC
      LIMIT 5
    ''', [startDate.toIso8601String(), endDate.toIso8601String()]);

    return SalesReport(
      date: endDate,
      totalSales: totalSales,
      totalOrders: totalOrders,
      averageOrderValue: totalOrders > 0 ? totalSales / totalOrders : 0,
      topProducts: topProducts
          .map((p) => ProductSales(
                productId: p['product_id'] as String,
                productName: p['product_name'] as String,
                quantity: p['total_quantity'] as int,
                totalSales: p['total_amount'] as double,
                averagePrice: p['average_price'] as double,
              ))
          .toList(),
      totalTax: totalTax,
      totalDiscount: totalDiscount,
      netSales: totalSales - totalTax - totalDiscount,
    );
  }

  Future<InventoryReport> getInventoryReport() async {
    final db = await _databaseHelper.database;

    // Get current inventory status
    final products = await db.rawQuery('''
      SELECT 
        p.id,
        p.name,
        p.quantity as current_stock,
        p.minimum_stock,
        p.price * p.quantity as value,
        (
          SELECT json_group_array(json_object(
            'date', created_at,
            'type', type,
            'quantity', quantity,
            'reason', reason
          ))
          FROM stock_adjustments sa
          WHERE sa.product_id = p.id
          ORDER BY created_at DESC
          LIMIT 5
        ) as recent_movements
      FROM products p
    ''');

    double totalValue = 0;
    int lowStockItems = 0;
    int outOfStockItems = 0;

    final inventoryProducts = products.map((p) {
      final value = p['value'] as double? ?? 0.0;
      final currentStock = p['current_stock'] as int? ?? 0;
      final minimumStock = p['minimum_stock'] as int? ?? 0;

      totalValue += value;
      if (currentStock <= minimumStock) lowStockItems++;
      if (currentStock == 0) outOfStockItems++;

      return ProductInventory(
        productId: p['id'] as String,
        productName: p['name'] as String,
        currentStock: currentStock,
        minimumStock: minimumStock,
        value: value,
        recentMovements: _parseStockMovements(p['recent_movements'] as String?),
      );
    }).toList();

    return InventoryReport(
      date: DateTime.now(),
      products: inventoryProducts,
      totalValue: totalValue,
      totalItems: products.length,
      lowStockItems: lowStockItems,
      outOfStockItems: outOfStockItems,
    );
  }

  Future<FinancialSummary> getFinancialSummary({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final db = await _databaseHelper.database;

    // Get daily revenue data
    final dailyData = await db.rawQuery('''
      SELECT 
        DATE(created_at) as date,
        SUM(total_amount) as revenue,
        SUM(cost_amount) as costs,
        SUM(total_amount - cost_amount) as profit
      FROM orders
      WHERE created_at BETWEEN ? AND ?
      GROUP BY DATE(created_at)
      ORDER BY date
    ''', [startDate.toIso8601String(), endDate.toIso8601String()]);

    // Get expense breakdown
    final expenses = await db.rawQuery('''
      SELECT 
        category,
        SUM(amount) as total
      FROM expenses
      WHERE date BETWEEN ? AND ?
      GROUP BY category
    ''', [startDate.toIso8601String(), endDate.toIso8601String()]);

    double totalRevenue = 0;
    double totalCosts = 0;
    double totalExpenses = 0;
    final dailyRevenue = <DailyRevenue>[];
    final expenseBreakdown = <String, double>{};

    for (final day in dailyData) {
      final revenue = day['revenue'] as double? ?? 0.0;
      final costs = day['costs'] as double? ?? 0.0;
      final profit = day['profit'] as double? ?? 0.0;

      totalRevenue += revenue;
      totalCosts += costs;

      dailyRevenue.add(DailyRevenue(
        date: DateTime.parse(day['date'] as String),
        revenue: revenue,
        costs: costs,
        profit: profit,
      ));
    }

    for (final expense in expenses) {
      final category = expense['category'] as String;
      final amount = expense['total'] as double? ?? 0.0;
      totalExpenses += amount;
      expenseBreakdown[category] = amount;
    }

    final grossProfit = totalRevenue - totalCosts;
    final taxes = totalRevenue * 0.16; // Assuming 16% VAT
    final netProfit = grossProfit - totalExpenses - taxes;

    return FinancialSummary(
      startDate: startDate,
      endDate: endDate,
      totalRevenue: totalRevenue,
      totalCosts: totalCosts,
      grossProfit: grossProfit,
      netProfit: netProfit,
      taxes: taxes,
      expenses: totalExpenses,
      dailyRevenue: dailyRevenue,
      expenseBreakdown: expenseBreakdown,
    );
  }

  Future<AnalyticsSummary> getAnalyticsSummary({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final db = await _databaseHelper.database;

    // Get sales trend
    final salesTrend = await db.rawQuery('''
      SELECT 
        DATE(created_at) as date,
        SUM(total_amount) as value
      FROM orders
      WHERE created_at BETWEEN ? AND ?
      GROUP BY DATE(created_at)
      ORDER BY date
    ''', [startDate.toIso8601String(), endDate.toIso8601String()]);

    // Get category distribution
    final categoryDistribution = await db.rawQuery('''
      SELECT 
        c.name as category,
        SUM(oi.total_amount) as value
      FROM order_items oi
      JOIN products p ON p.id = oi.product_id
      JOIN categories c ON c.id = p.category_id
      JOIN orders o ON o.id = oi.order_id
      WHERE o.created_at BETWEEN ? AND ?
      GROUP BY c.id
    ''', [startDate.toIso8601String(), endDate.toIso8601String()]);

    // Get payment method distribution
    final paymentMethods = await db.rawQuery('''
      SELECT 
        payment_method,
        SUM(total_amount) as value
      FROM orders
      WHERE created_at BETWEEN ? AND ?
      GROUP BY payment_method
    ''', [startDate.toIso8601String(), endDate.toIso8601String()]);

    // Calculate growth rate
    final previousPeriodSales = await db.rawQuery('''
      SELECT SUM(total_amount) as value
      FROM orders
      WHERE created_at BETWEEN ? AND ?
    ''', [
      startDate.subtract(endDate.difference(startDate)).toIso8601String(),
      startDate.toIso8601String()
    ]);

    final currentPeriodSales = await db.rawQuery('''
      SELECT SUM(total_amount) as value
      FROM orders
      WHERE created_at BETWEEN ? AND ?
    ''', [startDate.toIso8601String(), endDate.toIso8601String()]);

    final previousValue = previousPeriodSales.first['value'] as double? ?? 0.0;
    final currentValue = currentPeriodSales.first['value'] as double? ?? 0.0;
    final growthRate = previousValue > 0
        ? ((currentValue - previousValue) / previousValue) * 100
        : 0.0;

    return AnalyticsSummary(
      salesTrend: salesTrend
          .map((data) => ChartData(
                date: DateTime.parse(data['date'] as String),
                value: data['value'] as double? ?? 0.0,
              ))
          .toList(),
      profitTrend: [], // TODO: Implement profit trend calculation
      categoryDistribution: Map.fromEntries(
        categoryDistribution.map(
          (data) => MapEntry(
            data['category'] as String,
            data['value'] as double? ?? 0.0,
          ),
        ),
      ),
      paymentMethodDistribution: Map.fromEntries(
        paymentMethods.map(
          (data) => MapEntry(
            data['payment_method'] as String,
            data['value'] as double? ?? 0.0,
          ),
        ),
      ),
      hourlyTraffic: [], // TODO: Implement hourly traffic calculation
      growthRate: growthRate,
      customerSegmentation: {}, // TODO: Implement customer segmentation
    );
  }

  List<StockMovement> _parseStockMovements(String? jsonString) {
    if (jsonString == null) return [];

    try {
      final List<dynamic> movements = _databaseHelper.jsonDecode(jsonString);
      return movements
          .map((m) => StockMovement(
                date: DateTime.parse(m['date'] as String),
                type: m['type'] as String,
                quantity: m['quantity'] as int,
                reason: m['reason'] as String?,
              ))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
