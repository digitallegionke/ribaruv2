import 'package:flutter/material.dart';
import 'package:ribaru_v2/core/theme/app_theme.dart';
import 'package:ribaru_v2/features/reports/domain/models/report_data.dart';
import 'package:ribaru_v2/features/reports/presentation/widgets/chart_card.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedPeriod = 'This Week';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports & Analytics'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Sales'),
            Tab(text: 'Inventory'),
            Tab(text: 'Financial'),
            Tab(text: 'Analytics'),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            initialValue: _selectedPeriod,
            onSelected: (String value) {
              setState(() {
                _selectedPeriod = value;
              });
            },
            itemBuilder: (BuildContext context) {
              return [
                'Today',
                'This Week',
                'This Month',
                'Last 3 Months',
                'This Year',
              ].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(_selectedPeriod),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSalesReport(),
          _buildInventoryReport(),
          _buildFinancialReport(),
          _buildAnalytics(),
        ],
      ),
    );
  }

  Widget _buildSalesReport() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSummaryCards(),
        const SizedBox(height: 16),
        ChartCard(
          title: 'Sales Trend',
          subtitle: 'Daily sales for $_selectedPeriod',
          data: _getDummyChartData(),
          height: 250,
        ),
        const SizedBox(height: 16),
        ChartCard(
          title: 'Hourly Sales',
          subtitle: 'Sales distribution by hour',
          data: _getDummyChartData(),
          showBarChart: true,
          color: AppColors.secondary,
        ),
        const SizedBox(height: 16),
        _buildTopProductsList(),
      ],
    );
  }

  Widget _buildInventoryReport() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildInventorySummaryCards(),
        const SizedBox(height: 16),
        ChartCard(
          title: 'Stock Levels',
          subtitle: 'Current stock value by category',
          data: _getDummyChartData(),
          showBarChart: true,
        ),
        const SizedBox(height: 16),
        _buildLowStockList(),
      ],
    );
  }

  Widget _buildFinancialReport() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildFinancialSummaryCards(),
        const SizedBox(height: 16),
        ChartCard(
          title: 'Revenue vs Costs',
          subtitle: 'Daily comparison for $_selectedPeriod',
          data: _getDummyChartData(),
          color: AppColors.success,
        ),
        const SizedBox(height: 16),
        _buildExpenseBreakdown(),
      ],
    );
  }

  Widget _buildAnalytics() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildAnalyticsSummaryCards(),
        const SizedBox(height: 16),
        ChartCard(
          title: 'Growth Rate',
          subtitle: 'Month over month growth',
          data: _getDummyChartData(),
          color: AppColors.info,
        ),
        const SizedBox(height: 16),
        _buildCustomerSegmentation(),
      ],
    );
  }

  Widget _buildSummaryCards() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildSummaryCard(
          'Total Sales',
          'KES 125,000',
          Icons.attach_money,
          AppColors.success,
        ),
        _buildSummaryCard(
          'Orders',
          '48',
          Icons.shopping_cart,
          AppColors.info,
        ),
        _buildSummaryCard(
          'Average Order',
          'KES 2,604',
          Icons.analytics,
          AppColors.warning,
        ),
        _buildSummaryCard(
          'Net Profit',
          'KES 31,250',
          Icons.trending_up,
          AppColors.secondary,
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
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  List<ChartData> _getDummyChartData() {
    // Replace with actual data
    return List.generate(
      7,
      (index) => ChartData(
        date: DateTime.now().subtract(Duration(days: 6 - index)),
        value: 50 + (index * 10) + (index % 2 == 0 ? 20 : -10),
      ),
    );
  }

  Widget _buildTopProductsList() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Top Products',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Text('${index + 1}'),
                ),
                title: Text('Product ${index + 1}'),
                subtitle: Text('${20 - index} units sold'),
                trailing: Text('KES ${1000 * (5 - index)}'),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInventorySummaryCards() {
    // Similar to _buildSummaryCards but with inventory metrics
    return const Placeholder(fallbackHeight: 100);
  }

  Widget _buildLowStockList() {
    // List of products with low stock
    return const Placeholder(fallbackHeight: 200);
  }

  Widget _buildFinancialSummaryCards() {
    // Similar to _buildSummaryCards but with financial metrics
    return const Placeholder(fallbackHeight: 100);
  }

  Widget _buildExpenseBreakdown() {
    // Pie chart or list of expenses by category
    return const Placeholder(fallbackHeight: 200);
  }

  Widget _buildAnalyticsSummaryCards() {
    // Similar to _buildSummaryCards but with analytics metrics
    return const Placeholder(fallbackHeight: 100);
  }

  Widget _buildCustomerSegmentation() {
    // Pie chart or list of customer segments
    return const Placeholder(fallbackHeight: 200);
  }
}
