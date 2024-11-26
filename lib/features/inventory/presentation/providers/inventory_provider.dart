import 'package:flutter/foundation.dart';
import 'package:ribaru_v2/features/inventory/data/repositories/inventory_repository.dart';
import 'package:ribaru_v2/features/inventory/domain/models/category.dart';
import 'package:ribaru_v2/features/inventory/domain/models/product.dart';

class InventoryProvider extends ChangeNotifier {
  final InventoryRepository _repository = InventoryRepository();

  List<Product> _products = [];
  List<Category> _categories = [];
  String? _searchQuery;
  String? _selectedCategoryId;
  bool _showLowStock = false;
  bool _isLoading = false;
  String? _error;

  // Getters
  List<Product> get products => _products;
  List<Category> get categories => _categories;
  String? get searchQuery => _searchQuery;
  String? get selectedCategoryId => _selectedCategoryId;
  bool get showLowStock => _showLowStock;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Initialize
  Future<void> init() async {
    await Future.wait([
      loadCategories(),
      loadProducts(),
    ]);
  }

  // Product methods
  Future<void> loadProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await _repository.getProducts(
        search: _searchQuery,
        categoryId: _selectedCategoryId,
        lowStock: _showLowStock,
      );
    } catch (e) {
      _error = 'Failed to load products: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Product?> getProduct(String id) async {
    try {
      return await _repository.getProductById(id);
    } catch (e) {
      _error = 'Failed to get product: $e';
      notifyListeners();
      return null;
    }
  }

  Future<bool> createProduct({
    required String name,
    String? description,
    required double price,
    required int quantity,
    String? categoryId,
    String? barcode,
    String? imageUrl,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.createProduct(
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        categoryId: categoryId,
        barcode: barcode,
        imageUrl: imageUrl,
      );
      await loadProducts();
      return true;
    } catch (e) {
      _error = 'Failed to create product: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateProduct(Product product) async {
    try {
      final success = await _repository.updateProduct(product);
      if (success) {
        await loadProducts();
      }
      return success;
    } catch (e) {
      _error = 'Failed to update product: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      final success = await _repository.deleteProduct(id);
      if (success) {
        await loadProducts();
      }
      return success;
    } catch (e) {
      _error = 'Failed to delete product: $e';
      notifyListeners();
      return false;
    }
  }

  /// Get a product by ID
  Future<Product?> getProductDetails(String id) async {
    try {
      final db = await _repository.database;
      final List<Map<String, dynamic>> maps = await db.query(
        'products',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isEmpty) return null;
      return Product.fromMap(maps.first);
    } catch (e) {
      _error = 'Error getting product: $e';
      notifyListeners();
      return null;
    }
  }

  /// Get stock history for a product
  Future<List<Map<String, dynamic>>> getStockHistory(String productId) async {
    try {
      final db = await _repository.database;
      return await db.query(
        'stock_adjustments',
        where: 'product_id = ?',
        whereArgs: [productId],
        orderBy: 'created_at DESC',
      );
    } catch (e) {
      _error = 'Error getting stock history: $e';
      notifyListeners();
      return [];
    }
  }

  /// Adjust stock for a product
  Future<void> adjustStock({
    required String productId,
    required int quantity,
    String? reason,
  }) async {
    try {
      final db = await _repository.database;
      await db.transaction((txn) async {
        // Get current product
        final List<Map<String, dynamic>> products = await txn.query(
          'products',
          where: 'id = ?',
          whereArgs: [productId],
        );

        if (products.isEmpty) {
          throw Exception('Product not found');
        }

        final product = Product.fromMap(products.first);
        final newQuantity = product.quantity + quantity;

        if (newQuantity < 0) {
          throw Exception('Insufficient stock');
        }

        // Update product quantity
        await txn.update(
          'products',
          {'quantity': newQuantity},
          where: 'id = ?',
          whereArgs: [productId],
        );

        // Record stock adjustment
        await txn.insert('stock_adjustments', {
          'id': const Uuid().v4(),
          'product_id': productId,
          'quantity': quantity,
          'type': quantity > 0 ? 'add' : 'remove',
          'reason': reason,
          'created_at': DateTime.now().toIso8601String(),
        });
      });

      notifyListeners();
    } catch (e) {
      _error = 'Error adjusting stock: $e';
      rethrow;
    }
  }

  // Category methods
  Future<void> loadCategories() async {
    try {
      _categories = await _repository.getCategories();
      notifyListeners();
    } catch (e) {
      _error = 'Failed to load categories: $e';
      notifyListeners();
    }
  }

  Future<bool> createCategory(String name, {String? description, String? color}) async {
    try {
      await _repository.createCategory(name, description: description, color: color);
      await loadCategories();
      return true;
    } catch (e) {
      _error = 'Failed to create category: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateCategory(Category category) async {
    try {
      final success = await _repository.updateCategory(category);
      if (success) {
        await loadCategories();
      }
      return success;
    } catch (e) {
      _error = 'Failed to update category: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteCategory(String id) async {
    try {
      final success = await _repository.deleteCategory(id);
      if (success) {
        await loadCategories();
        if (_selectedCategoryId == id) {
          _selectedCategoryId = null;
          await loadProducts();
        }
      }
      return success;
    } catch (e) {
      _error = 'Failed to delete category: $e';
      notifyListeners();
      return false;
    }
  }

  // Filter methods
  void setSearchQuery(String? query) {
    _searchQuery = query;
    loadProducts();
  }

  void setSelectedCategory(String? categoryId) {
    _selectedCategoryId = categoryId;
    loadProducts();
  }

  void toggleLowStock() {
    _showLowStock = !_showLowStock;
    loadProducts();
  }

  void clearFilters() {
    _searchQuery = null;
    _selectedCategoryId = null;
    _showLowStock = false;
    loadProducts();
  }
}
