import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ribaru_v2/core/theme/app_theme.dart';
import 'package:ribaru_v2/core/widgets/app_button.dart';
import 'package:ribaru_v2/features/inventory/domain/models/product.dart';
import 'package:ribaru_v2/features/inventory/presentation/providers/inventory_provider.dart';

class StockAdjustmentScreen extends StatefulWidget {
  final String productId;

  const StockAdjustmentScreen({
    super.key,
    required this.productId,
  });

  @override
  State<StockAdjustmentScreen> createState() => _StockAdjustmentScreenState();
}

class _StockAdjustmentScreenState extends State<StockAdjustmentScreen> {
  late Future<Product?> _productFuture;
  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController();
  final _reasonController = TextEditingController();
  String _adjustmentType = 'add';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  void _loadProduct() {
    _productFuture =
        context.read<InventoryProvider>().getProduct(widget.productId);
  }

  Future<void> _submitAdjustment(Product product) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final quantity = int.parse(_quantityController.text);
      final adjustedQuantity =
          _adjustmentType == 'add' ? quantity : -quantity;

      await context.read<InventoryProvider>().adjustStock(
            productId: widget.productId,
            quantity: adjustedQuantity,
            reason: _reasonController.text.trim(),
          );

      if (mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Successfully ${_adjustmentType == 'add' ? 'added' : 'removed'} $quantity items',
            ),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error adjusting stock: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adjust Stock'),
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Current stock: ${product.quantity}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Adjustment Type',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment<String>(
                        value: 'add',
                        label: Text('Add Stock'),
                        icon: Icon(Icons.add_circle),
                      ),
                      ButtonSegment<String>(
                        value: 'remove',
                        label: Text('Remove Stock'),
                        icon: Icon(Icons.remove_circle),
                      ),
                    ],
                    selected: {_adjustmentType},
                    onSelectionChanged: (Set<String> newSelection) {
                      setState(() {
                        _adjustmentType = newSelection.first;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _quantityController,
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
                      hintText: 'Enter quantity to adjust',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a quantity';
                      }
                      final quantity = int.tryParse(value);
                      if (quantity == null || quantity <= 0) {
                        return 'Please enter a valid quantity';
                      }
                      if (_adjustmentType == 'remove' &&
                          quantity > product.quantity) {
                        return 'Cannot remove more than current stock';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _reasonController,
                    decoration: const InputDecoration(
                      labelText: 'Reason (Optional)',
                      hintText: 'Enter reason for adjustment',
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      onPressed:
                          _isLoading ? null : () => _submitAdjustment(product),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              _adjustmentType == 'add'
                                  ? 'Add to Stock'
                                  : 'Remove from Stock',
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
