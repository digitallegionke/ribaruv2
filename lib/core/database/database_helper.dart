import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "ribaru.db";
  static const _databaseVersion = 1;

  // Singleton pattern
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create categories table
    await db.execute('''
      CREATE TABLE categories(
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT,
        color TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // Create products table
    await db.execute('''
      CREATE TABLE products(
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT,
        price REAL NOT NULL,
        quantity INTEGER NOT NULL,
        category_id TEXT,
        barcode TEXT,
        image_url TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY(category_id) REFERENCES categories(id)
      )
    ''');

    // Create stock adjustments table
    await _createStockAdjustmentsTable(db);
  }

  Future<void> _createStockAdjustmentsTable(Database db) async {
    await db.execute('''
      CREATE TABLE stock_adjustments (
        id TEXT PRIMARY KEY,
        product_id TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        type TEXT NOT NULL,
        reason TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database upgrades here
  }

  // Helper methods for categories
  Future<String> insertCategory(Map<String, dynamic> category) async {
    Database db = await database;
    await db.insert('categories', category);
    return category['id'] as String;
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    Database db = await database;
    return await db.query('categories', orderBy: 'name');
  }

  Future<Map<String, dynamic>?> getCategoryById(String id) async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<int> updateCategory(Map<String, dynamic> category) async {
    Database db = await database;
    return await db.update(
      'categories',
      category,
      where: 'id = ?',
      whereArgs: [category['id']],
    );
  }

  Future<int> deleteCategory(String id) async {
    Database db = await database;
    return await db.delete(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Helper methods for products
  Future<String> insertProduct(Map<String, dynamic> product) async {
    Database db = await database;
    await db.insert('products', product);
    return product['id'] as String;
  }

  Future<List<Map<String, dynamic>>> getProducts({
    String? search,
    String? categoryId,
    bool? lowStock,
  }) async {
    Database db = await database;
    String whereClause = '';
    List<dynamic> whereArgs = [];

    if (search != null && search.isNotEmpty) {
      whereClause += 'name LIKE ? OR barcode = ?';
      whereArgs.addAll(['%$search%', search]);
    }

    if (categoryId != null) {
      if (whereClause.isNotEmpty) whereClause += ' AND ';
      whereClause += 'category_id = ?';
      whereArgs.add(categoryId);
    }

    if (lowStock == true) {
      if (whereClause.isNotEmpty) whereClause += ' AND ';
      whereClause += 'quantity <= 10'; // TODO: Make threshold configurable
    }

    return await db.query(
      'products',
      where: whereClause.isEmpty ? null : whereClause,
      whereArgs: whereArgs.isEmpty ? null : whereArgs,
      orderBy: 'name',
    );
  }

  Future<Map<String, dynamic>?> getProductById(String id) async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<int> updateProduct(Map<String, dynamic> product) async {
    Database db = await database;
    return await db.update(
      'products',
      product,
      where: 'id = ?',
      whereArgs: [product['id']],
    );
  }

  Future<int> deleteProduct(String id) async {
    Database db = await database;
    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Helper methods for stock adjustments
  Future<String> insertStockAdjustment(Map<String, dynamic> adjustment) async {
    Database db = await database;
    await db.transaction((txn) async {
      // Insert the adjustment record
      await txn.insert('stock_adjustments', adjustment);

      // Update product quantity
      await txn.rawUpdate('''
        UPDATE products 
        SET quantity = quantity + ?,
            updated_at = ?
        WHERE id = ?
      ''', [
        adjustment['quantity'],
        DateTime.now().toIso8601String(),
        adjustment['product_id'],
      ]);
    });
    return adjustment['id'] as String;
  }

  Future<List<Map<String, dynamic>>> getStockAdjustments(String productId) async {
    Database db = await database;
    return await db.query(
      'stock_adjustments',
      where: 'product_id = ?',
      whereArgs: [productId],
      orderBy: 'created_at DESC',
    );
  }
}
