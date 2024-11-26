import 'package:flutter/material.dart';
import 'package:ribaru_v2/core/theme/app_theme.dart';
import 'package:ribaru_v2/features/reports/domain/models/report_data.dart';
import 'package:ribaru_v2/features/reports/presentation/widgets/chart_card.dart';

class FinancialReportSection extends StatelessWidget {
  final FinancialSummary? summary;
  final bool isLoading;
  final VoidCallback onExport;
  final VoidCallback onPrint;

  const FinancialReportSection({
    super.key,
    required this.summary,
    required this.isLoading,
    required this.onExport,
    required this.onPrint,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (summary == null) {
      return const Center(child: Text('No data available'));
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildFinancialSummaryCards(),
        const SizedBox(height: 16),
        _buildRevenueChart(),
        const SizedBox(height: 16),
        _buildExpenseBreakdown(),
        const SizedBox(height: 16),
        _buildDailyRevenueList(),
        const SizedBox(height: 16),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildFinancialSummaryCards() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildSummaryCard(
          'Total Revenue',
          'KES ${summary!.totalRevenue.toStringAsFixed(2)}',
          Icons.trending_up,
          AppColors.success,
        ),
        _buildSummaryCard(
          'Net Profit',
          'KES ${summary!.netProfit.toStringAsFixed(2)}',
          Icons.account_balance,
          AppColors.info,
        ),
        _buildSummaryCard(
          'Total Expenses',
          'KES ${summary!.expenses.toStringAsFixed(2)}',
          Icons.money_off,
          AppColors.warning,
        ),
        _buildSummaryCard(
          'Taxes',
          'KES ${summary!.taxes.toStringAsFixed(2)}',
          Icons.receipt_long,
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

  Widget _buildRevenueChart() {
    final revenueData = summary!.dailyRevenue.map((daily) {
      return ChartData(
        date: daily.date,
        value: daily.revenue,
        secondaryValue: daily.costs,
      );
    }).toList();

    return ChartCard(
      title: 'Revenue vs Costs',
      subtitle: 'Daily comparison',
      data: revenueData,
      showLineChart: true,
      showSecondaryLine: true,
      color: AppColors.success,
      secondaryColor: AppColors.error,
      height: 300,
    );
  }

  Widget _buildExpenseBreakdown() {
    if (summary!.expenseBreakdown.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('No expense data available'),
        ),
      );
    }

    final expenseData = summary!.expenseBreakdown.entries.map((entry) {
      return ChartData(
        date: DateTime.now(),
        value: entry.value,
        label: entry.key,
      );
    }).toList();

    return ChartCard(
      title: 'Expense Breakdown',
      subtitle: 'By category',
      data: expenseData,
      showPieChart: true,
      color: AppColors.warning,
      height: 300,
    );
  }

  Widget _buildDailyRevenueList() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Daily Revenue',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: summary!.dailyRevenue.length,
            itemBuilder: (context, index) {
              final daily = summary!.dailyRevenue[index];
              final profit = daily.revenue - daily.costs;
              final isProfit = profit >= 0;

              return ListTile(
                title: Text(
                  daily.date.toString().split(' ')[0],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Revenue: KES ${daily.revenue.toStringAsFixed(2)}\n'
                  'Costs: KES ${daily.costs.toStringAsFixed(2)}',
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      isProfit ? 'Profit' : 'Loss',
                      style: TextStyle(
                        color: isProfit ? AppColors.success : AppColors.error,
                      ),
                    ),
                    Text(
                      'KES ${profit.abs().toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isProfit ? AppColors.success : AppColors.error,
                      ),
                    ),
                  ],
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
