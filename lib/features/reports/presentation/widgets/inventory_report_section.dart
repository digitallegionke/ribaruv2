import 'package:flutter/material.dart';
import 'package:ribaru_v2/core/theme/app_theme.dart';
import 'package:ribaru_v2/features/reports/domain/models/report_data.dart';
import 'package:ribaru_v2/features/reports/presentation/widgets/chart_card.dart';

class InventoryReportSection extends StatelessWidget {
  final InventoryReport? report;
  final bool isLoading;
  final VoidCallback onExport;
  final VoidCallback onPrint;

  const InventoryReportSection({
    super.key,
    required this.report,
    required this.isLoading,
    required this.onExport,
    required this.onPrint,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (report == null) {
      return const Center(child: Text('No data available'));
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildInventorySummaryCards(),
        const SizedBox(height: 16),
        _buildStockLevelsChart(),
        const SizedBox(height: 16),
        _buildLowStockList(),
        const SizedBox(height: 16),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildInventorySummaryCards() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildSummaryCard(
          'Total Value',
          'KES ${report!.totalValue.toStringAsFixed(2)}',
          Icons.attach_money,
          AppColors.success,
        ),
        _buildSummaryCard(
          'Total Items',
          report!.totalItems.toString(),
          Icons.inventory_2,
          AppColors.info,
        ),
        _buildSummaryCard(
          'Low Stock',
          report!.lowStockItems.toString(),
          Icons.warning,
          AppColors.warning,
        ),
        _buildSummaryCard(
          'Out of Stock',
          report!.outOfStockItems.toString(),
          Icons.error_outline,
          AppColors.error,
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStockLevelsChart() {
    final stockData = report!.products.map((product) {
      return ChartData(
        date: DateTime.now(),
        value: product.currentStock.toDouble(),
        label: product.productName,
      );
    }).toList();

    return ChartCard(
      title: 'Stock Levels by Product',
      subtitle: 'Current stock quantities',
      data: stockData,
      showBarChart: true,
      color: AppColors.primary,
      height: 300,
    );
  }

  Widget _buildLowStockList() {
    final lowStockProducts = report!.products
        .where((product) => product.currentStock <= product.minimumStock)
        .toList();

    if (lowStockProducts.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('No products are running low on stock'),
        ),
      );
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Low Stock Items',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: lowStockProducts.length,
            itemBuilder: (context, index) {
              final product = lowStockProducts[index];
              final stockStatus = product.currentStock == 0
                  ? 'Out of Stock'
                  : '${product.currentStock} left';
              final statusColor =
                  product.currentStock == 0 ? AppColors.error : AppColors.warning;

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: statusColor.withOpacity(0.1),
                  child: Icon(
                    product.currentStock == 0
                        ? Icons.error_outline
                        : Icons.warning,
                    color: statusColor,
                  ),
                ),
                title: Text(product.productName),
                subtitle: Text(
                  'Minimum: ${product.minimumStock}',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                trailing: Text(
                  stockStatus,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton.icon(
          onPressed: onPrint,
          icon: const Icon(Icons.print),
          label: const Text('Print'),
        ),
        const SizedBox(width: 8),
        FilledButton.icon(
          onPressed: onExport,
          icon: const Icon(Icons.download),
          label: const Text('Export'),
        ),
      ],
    );
  }
}
