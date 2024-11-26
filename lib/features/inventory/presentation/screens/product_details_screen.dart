import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ribaru_v2/core/theme/app_theme.dart';
import 'package:ribaru_v2/core/widgets/app_button.dart';
import 'package:ribaru_v2/features/inventory/domain/models/product.dart';
import 'package:ribaru_v2/features/inventory/presentation/providers/inventory_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;

  const ProductDetailsScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late Future<Product?> _productFuture;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  void _loadProduct() {
    _productFuture =
        context.read<InventoryProvider>().getProduct(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () =>
                context.push('/inventory/product/${widget.productId}/edit'),
          ),
        ],
      ),
      body: FutureBuilder<Product?>(
        future: _productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error loading product: ${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.error),
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    onPressed: _loadProduct,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final product = snapshot.data;
          if (product == null) {
            return const Center(
              child: Text('Product not found'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.imageUrl != null)
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(product.imageUrl!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                else
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.inventory_2,
                          size: 64,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          if (product.categoryId != null)
                            Consumer<InventoryProvider>(
                              builder: (context, provider, child) {
                                final category = provider.categories.firstWhere(
                                  (c) => c.id == product.categoryId,
                                  orElse: () => const Category(
                                    id: '',
                                    name: 'Uncategorized',
                                    createdAt: null,
                                    updatedAt: null,
                                  ),
                                );
                                return Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    category.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'KES ${product.price}',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: product.quantity <= 10
                                ? AppColors.warning.withOpacity(0.1)
                                : AppColors.success.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${product.quantity} in stock',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: product.quantity <= 10
                                      ? AppColors.warning
                                      : AppColors.success,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (product.description != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(product.description!),
                ],
                const SizedBox(height: 24),
                Text(
                  'Stock History',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: context
                      .read<InventoryProvider>()
                      .getStockHistory(product.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error loading stock history',
                          style: TextStyle(color: AppColors.error),
                        ),
                      );
                    }

                    final adjustments = snapshot.data ?? [];
                    if (adjustments.isEmpty) {
                      return const Center(
                        child: Text('No stock adjustments found'),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: adjustments.length,
                      itemBuilder: (context, index) {
                        final adjustment = adjustments[index];
                        final quantity = adjustment['quantity'] as int;
                        final type = adjustment['type'] as String;
                        final reason = adjustment['reason'] as String?;
                        final createdAt =
                            DateTime.parse(adjustment['created_at'] as String);

                        return Card(
                          child: ListTile(
                            leading: Icon(
                              type == 'add'
                                  ? Icons.add_circle
                                  : Icons.remove_circle,
                              color: type == 'add'
                                  ? AppColors.success
                                  : AppColors.error,
                            ),
                            title: Text(
                              type == 'add'
                                  ? '+$quantity added to stock'
                                  : '-$quantity removed from stock',
                            ),
                            subtitle: reason != null
                                ? Text(reason)
                                : Text(
                                    '${createdAt.day}/${createdAt.month}/${createdAt.year}'),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            context.push('/inventory/product/${widget.productId}/stock'),
        icon: const Icon(Icons.add_shopping_cart),
        label: const Text('Adjust Stock'),
      ),
    );
  }
}
