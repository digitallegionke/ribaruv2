import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ribaru_v2/core/theme/app_theme.dart';
import 'package:ribaru_v2/core/widgets/app_button.dart';
import 'package:ribaru_v2/core/widgets/app_text_field.dart';
import 'package:ribaru_v2/features/inventory/presentation/providers/inventory_provider.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InventoryProvider>().init();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Products'),
            Tab(text: 'Categories'),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: _searchController,
                    hintText: 'Search inventory...',
                    prefixIcon: const Icon(Icons.search),
                    onChanged: (value) {
                      context.read<InventoryProvider>().setSearchQuery(value);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                AppButton.icon(
                  onPressed: _showFilterDialog,
                  icon: const Icon(Icons.filter_list),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildProductsList(),
                _buildCategoriesList(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/inventory/add'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildProductsList() {
    return Consumer<InventoryProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  provider.error!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.error),
                ),
                const SizedBox(height: 16),
                AppButton(
                  onPressed: provider.loadProducts,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (provider.products.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.inventory_2_outlined,
                  size: 64,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(height: 16),
                Text(
                  'No products found',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                if (provider.searchQuery != null ||
                    provider.selectedCategoryId != null ||
                    provider.showLowStock) ...[
                  const SizedBox(height: 8),
                  AppButton(
                    onPressed: provider.clearFilters,
                    child: const Text('Clear Filters'),
                  ),
                ],
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: provider.products.length,
          itemBuilder: (context, index) {
            final product = provider.products[index];
            final category = provider.categories.firstWhere(
              (c) => c.id == product.categoryId,
              orElse: () => const Category(
                id: '',
                name: 'Uncategorized',
                createdAt: null,
                updatedAt: null,
              ),
            );

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: product.imageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product.imageUrl!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Center(
                          child: Icon(
                            Icons.inventory_2,
                            color: AppColors.primary,
                          ),
                        ),
                ),
                title: Text(product.name),
                subtitle: Text(
                  'Stock: ${product.quantity} • ${category.name} • KES ${product.price}',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => _showProductOptions(product),
                ),
                onTap: () => context.push('/inventory/product/${product.id}'),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCategoriesList() {
    return Consumer<InventoryProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  provider.error!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.error),
                ),
                const SizedBox(height: 16),
                AppButton(
                  onPressed: provider.loadCategories,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (provider.categories.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.category_outlined,
                  size: 64,
                  color: AppColors.textSecondary,
                ),
                SizedBox(height: 16),
                Text('No categories found'),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: provider.categories.length,
          itemBuilder: (context, index) {
            final category = provider.categories[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: category.color != null
                        ? Color(int.parse(category.color!))
                            .withOpacity(0.1)
                        : AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.category,
                      color: category.color != null
                          ? Color(int.parse(category.color!))
                          : AppColors.primary,
                    ),
                  ),
                ),
                title: Text(category.name),
                subtitle: Text(
                  provider.products
                      .where((p) => p.categoryId == category.id)
                      .length
                      .toString() +
                      ' products',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => _showCategoryOptions(category),
                ),
                onTap: () => context.push('/inventory/category/${category.id}'),
              ),
            );
          },
        );
      },
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Consumer<InventoryProvider>(
          builder: (context, provider, child) {
            return AlertDialog(
              title: const Text('Filter Products'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: provider.selectedCategoryId,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('All Categories'),
                      ),
                      ...provider.categories.map((category) {
                        return DropdownMenuItem(
                          value: category.id,
                          child: Text(category.name),
                        );
                      }),
                    ],
                    onChanged: (value) {
                      provider.setSelectedCategory(value);
                      context.pop();
                    },
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Show Low Stock Only'),
                    value: provider.showLowStock,
                    onChanged: (value) {
                      provider.toggleLowStock();
                      context.pop();
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    provider.clearFilters();
                    context.pop();
                  },
                  child: const Text('Clear All'),
                ),
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showProductOptions(Product product) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Product'),
                onTap: () {
                  context.pop();
                  context.push('/inventory/product/${product.id}/edit');
                },
              ),
              ListTile(
                leading: const Icon(Icons.add_shopping_cart),
                title: const Text('Adjust Stock'),
                onTap: () {
                  context.pop();
                  context.push('/inventory/product/${product.id}/stock');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.delete,
                  color: AppColors.error,
                ),
                title: Text(
                  'Delete Product',
                  style: TextStyle(color: AppColors.error),
                ),
                onTap: () {
                  context.pop();
                  _confirmDeleteProduct(product);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCategoryOptions(Category category) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Category'),
                onTap: () {
                  context.pop();
                  context.push('/inventory/category/${category.id}/edit');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.delete,
                  color: AppColors.error,
                ),
                title: Text(
                  'Delete Category',
                  style: TextStyle(color: AppColors.error),
                ),
                onTap: () {
                  context.pop();
                  _confirmDeleteCategory(category);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _confirmDeleteProduct(Product product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Product'),
          content: Text(
            'Are you sure you want to delete "${product.name}"? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<InventoryProvider>().deleteProduct(product.id);
                context.pop();
              },
              child: Text(
                'Delete',
                style: TextStyle(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteCategory(Category category) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Category'),
          content: Text(
            'Are you sure you want to delete "${category.name}"? Products in this category will become uncategorized.',
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<InventoryProvider>().deleteCategory(category.id);
                context.pop();
              },
              child: Text(
                'Delete',
                style: TextStyle(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );
  }
}
