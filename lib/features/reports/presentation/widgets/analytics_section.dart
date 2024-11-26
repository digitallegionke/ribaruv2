import 'package:flutter/material.dart';
import 'package:ribaru_v2/core/theme/app_theme.dart';
import 'package:ribaru_v2/features/reports/domain/models/report_data.dart';
import 'package:ribaru_v2/features/reports/presentation/widgets/chart_card.dart';

class AnalyticsSection extends StatelessWidget {
  final AnalyticsSummary? summary;
  final bool isLoading;
  final VoidCallback onExport;
  final VoidCallback onPrint;

  const AnalyticsSection({
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
        _buildGrowthCard(),
        const SizedBox(height: 16),
        _buildSalesTrendChart(),
        const SizedBox(height: 16),
        _buildCategoryDistribution(),
        const SizedBox(height: 16),
        _buildPaymentMethodDistribution(),
        const SizedBox(height: 16),
        _buildHourlyTraffic(),
        const SizedBox(height: 16),
        _buildCustomerSegmentation(),
        const SizedBox(height: 16),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildGrowthCard() {
    final growthColor = summary!.growthRate >= 0 ? AppColors.success : AppColors.error;
    final growthIcon = summary!.growthRate >= 0 ? Icons.trending_up : Icons.trending_down;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Icon(
              growthIcon,
              color: growthColor,
              size: 48,
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Growth Rate',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${summary!.growthRate.toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: growthColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesTrendChart() {
    return ChartCard(
      title: 'Sales Trend',
      subtitle: 'Daily sales over time',
      data: summary!.salesTrend,
      showLineChart: true,
      color: AppColors.primary,
      height: 300,
    );
  }

  Widget _buildCategoryDistribution() {
    if (summary!.categoryDistribution.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('No category data available'),
        ),
      );
    }

    final categoryData = summary!.categoryDistribution.entries.map((entry) {
      return ChartData(
        date: DateTime.now(),
        value: entry.value,
        label: entry.key,
      );
    }).toList();

    return ChartCard(
      title: 'Sales by Category',
      subtitle: 'Distribution of sales across categories',
      data: categoryData,
      showPieChart: true,
      color: AppColors.info,
      height: 300,
    );
  }

  Widget _buildPaymentMethodDistribution() {
    if (summary!.paymentMethodDistribution.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('No payment method data available'),
        ),
      );
    }

    final paymentData = summary!.paymentMethodDistribution.entries.map((entry) {
      return ChartData(
        date: DateTime.now(),
        value: entry.value,
        label: entry.key,
      );
    }).toList();

    return ChartCard(
      title: 'Payment Methods',
      subtitle: 'Distribution of payment methods',
      data: paymentData,
      showPieChart: true,
      color: AppColors.secondary,
      height: 300,
    );
  }

  Widget _buildHourlyTraffic() {
    if (summary!.hourlyTraffic.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('No hourly traffic data available'),
        ),
      );
    }

    return ChartCard(
      title: 'Hourly Traffic',
      subtitle: 'Sales distribution by hour',
      data: summary!.hourlyTraffic,
      showBarChart: true,
      color: AppColors.warning,
      height: 300,
    );
  }

  Widget _buildCustomerSegmentation() {
    if (summary!.customerSegmentation.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('No customer segmentation data available'),
        ),
      );
    }

    final segmentData = summary!.customerSegmentation.entries.map((entry) {
      return ChartData(
        date: DateTime.now(),
        value: entry.value,
        label: entry.key,
      );
    }).toList();

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Customer Segments',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: segmentData.length,
            itemBuilder: (context, index) {
              final segment = segmentData[index];
              return ListTile(
                title: Text(segment.label!),
                trailing: Text(
                  '${segment.value.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: LinearProgressIndicator(
                  value: segment.value / 100,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
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
