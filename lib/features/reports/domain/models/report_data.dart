import 'package:intl/intl.dart';

class SalesReport {
  final DateTime date;
  final double totalSales;
  final int totalOrders;
  final double averageOrderValue;
  final List<ProductSales> topProducts;
  final double totalTax;
  final double totalDiscount;
  final double netSales;

  SalesReport({
    required this.date,
    required this.totalSales,
    required this.totalOrders,
    required this.averageOrderValue,
    required this.topProducts,
    required this.totalTax,
    required this.totalDiscount,
    required this.netSales,
  });

  String get formattedDate => DateFormat('MMM d, y').format(date);
}

class ProductSales {
  final String productId;
  final String productName;
  final int quantity;
  final double totalSales;
  final double averagePrice;

  ProductSales({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.totalSales,
    required this.averagePrice,
  });
}

class InventoryReport {
  final DateTime date;
  final List<ProductInventory> products;
  final double totalValue;
  final int totalItems;
  final int lowStockItems;
  final int outOfStockItems;

  InventoryReport({
    required this.date,
    required this.products,
    required this.totalValue,
    required this.totalItems,
    required this.lowStockItems,
    required this.outOfStockItems,
  });

  String get formattedDate => DateFormat('MMM d, y').format(date);
}

class ProductInventory {
  final String productId;
  final String productName;
  final int currentStock;
  final int minimumStock;
  final double value;
  final List<StockMovement> recentMovements;

  ProductInventory({
    required this.productId,
    required this.productName,
    required this.currentStock,
    required this.minimumStock,
    required this.value,
    required this.recentMovements,
  });

  bool get isLowStock => currentStock <= minimumStock;
  bool get isOutOfStock => currentStock == 0;
}

class StockMovement {
  final DateTime date;
  final String type;
  final int quantity;
  final String? reason;

  StockMovement({
    required this.date,
    required this.type,
    required this.quantity,
    this.reason,
  });
}

class FinancialSummary {
  final DateTime startDate;
  final DateTime endDate;
  final double totalRevenue;
  final double totalCosts;
  final double grossProfit;
  final double netProfit;
  final double taxes;
  final double expenses;
  final List<DailyRevenue> dailyRevenue;
  final Map<String, double> expenseBreakdown;

  FinancialSummary({
    required this.startDate,
    required this.endDate,
    required this.totalRevenue,
    required this.totalCosts,
    required this.grossProfit,
    required this.netProfit,
    required this.taxes,
    required this.expenses,
    required this.dailyRevenue,
    required this.expenseBreakdown,
  });

  String get formattedDateRange =>
      '${DateFormat('MMM d, y').format(startDate)} - ${DateFormat('MMM d, y').format(endDate)}';
}

class DailyRevenue {
  final DateTime date;
  final double revenue;
  final double costs;
  final double profit;

  DailyRevenue({
    required this.date,
    required this.revenue,
    required this.costs,
    required this.profit,
  });
}

class AnalyticsSummary {
  final List<ChartData> salesTrend;
  final List<ChartData> profitTrend;
  final Map<String, double> categoryDistribution;
  final Map<String, double> paymentMethodDistribution;
  final List<ChartData> hourlyTraffic;
  final double growthRate;
  final Map<String, double> customerSegmentation;

  AnalyticsSummary({
    required this.salesTrend,
    required this.profitTrend,
    required this.categoryDistribution,
    required this.paymentMethodDistribution,
    required this.hourlyTraffic,
    required this.growthRate,
    required this.customerSegmentation,
  });
}

class ChartData {
  final DateTime date;
  final double value;
  final String? label;

  ChartData({
    required this.date,
    required this.value,
    this.label,
  });
}
