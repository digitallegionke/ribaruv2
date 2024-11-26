import 'package:ribaru_v2/core/database/database_helper.dart';
import 'package:ribaru_v2/features/inventory/domain/models/category.dart';
import 'package:ribaru_v2/features/inventory/domain/models/product.dart';
import 'package:uuid/uuid.dart';

class InventoryRepository {
  final DatabaseHelper _db = DatabaseHelper.instance;
  final _uuid = const Uuid();

  // Category methods
  Future<String> createCategory(String name, {String? description, String? color}) async {
    final now = DateTime.now();
    final category = {
      'id': _uuid.v4(),
      'name': name,
      'description': description,
      'color': color,
      'created_at': now.toIso8601String(),
      'updated_at': now.toIso8601String(),
    };

    return await _db.insertCategory(category);
  }

  Future<List<Category>> getCategories() async {
    final results = await _db.getCategories();
    return results.map((map) => Category.fromMap(map)).toList();
  }

  Future<Category?> getCategoryById(String id) async {
    final result = await _db.getCategoryById(id);
    return result != null ? Category.fromMap(result) : null;
  }

  Future<bool> updateCategory(Category category) async {
    final map = category.toMap();
    map['updated_at'] = DateTime.now().toIso8601String();
    final result = await _db.updateCategory(map);
    return result > 0;
  }

  Future<bool> deleteCategory(String id) async {
    final result = await _db.deleteCategory(id);
    return result > 0;
  }

  // Product methods
  Future<String> createProduct({
    required String name,
    String? description,
    required double price,
    required int quantity,
    String? categoryId,
    String? barcode,
    String? imageUrl,
  }) async {
    final now = DateTime.now();
    final product = {
      'id': _uuid.v4(),
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'category_id': categoryId,
      'barcode': barcode,
      'image_url': imageUrl,
      'created_at': now.toIso8601String(),
      'updated_at': now.toIso8601String(),
    };

    return await _db.insertProduct(product);
  }

  Future<List<Product>> getProducts({
    String? search,
    String? categoryId,
    bool? lowStock,
  }) async {
    final results = await _db.getProducts(
      search: search,
      categoryId: categoryId,
      lowStock: lowStock,
    );
    return results.map((map) => Product.fromMap(map)).toList();
  }

  Future<Product?> getProductById(String id) async {
    final result = await _db.getProductById(id);
    return result != null ? Product.fromMap(result) : null;
  }

  Future<bool> updateProduct(Product product) async {
    final map = product.toMap();
    map['updated_at'] = DateTime.now().toIso8601String();
    final result = await _db.updateProduct(map);
    return result > 0;
  }

  Future<bool> deleteProduct(String id) async {
    final result = await _db.deleteProduct(id);
    return result > 0;
  }

  // Stock adjustment methods
  Future<String> adjustStock({
    required String productId,
    required int quantity,
    required String type,
    String? reason,
  }) async {
    final adjustment = {
      'id': _uuid.v4(),
      'product_id': productId,
      'quantity': quantity,
      'type': type,
      'reason': reason,
      'created_at': DateTime.now().toIso8601String(),
    };

    return await _db.insertStockAdjustment(adjustment);
  }

  Future<List<Map<String, dynamic>>> getStockHistory(String productId) async {
    return await _db.getStockAdjustments(productId);
  }
}
