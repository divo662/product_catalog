import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/category_model.dart';
import '../models/product_models.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      final appSupportDir = await getApplicationSupportDirectory();
      final path = join(appSupportDir.path, 'product_catalog.db');
      return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
        onOpen: (db) {},
      );
    } catch (e) {
      rethrow;
    }
  }
  Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE categories(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE products(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          description TEXT,
          price REAL,
          imageUrl TEXT,
          categoryId INTEGER,
          FOREIGN KEY(categoryId) REFERENCES categories(id)
        )
      ''');
    } catch (e) {
      rethrow;
    }
  }

  Future<int> insertCategory(Category category) async {
    try {
      final db = await database;
      int result = await db.insert('categories', category.toMap());
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Category>> getCategories() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('categories');
      return List.generate(maps.length, (i) {
        return Category.fromMap(maps[i]);
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<int> insertProduct(Product product) async {
    try {
      final db = await database;
      int result = await db.insert('products', product.toMap());
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Product>> getProducts(
      {int? categoryId, double? minPrice, double? maxPrice}) async {
    try {
      final db = await database;

      String whereString = '';
      List<dynamic> whereArguments = [];

      if (categoryId != null) {
        whereString += 'categoryId = ?';
        whereArguments.add(categoryId);
      }

      if (minPrice != null) {
        if (whereString.isNotEmpty) whereString += ' AND ';
        whereString += 'price >= ?';
        whereArguments.add(minPrice);
      }

      if (maxPrice != null) {
        if (whereString.isNotEmpty) whereString += ' AND ';
        whereString += 'price <= ?';
        whereArguments.add(maxPrice);
      }

      final List<Map<String, dynamic>> maps = await db.query(
        'products',
        where: whereString.isNotEmpty ? whereString : null,
        whereArgs: whereArguments.isNotEmpty ? whereArguments : null,
      );

      return List.generate(maps.length, (i) {
        return Product.fromMap(maps[i]);
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<int> updateProduct(Product product) async {
    try {
      final db = await database;
      int result = await db.update(
        'products',
        product.toMap(),
        where: 'id = ?',
        whereArgs: [product.id],
      );
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> deleteProduct(int id) async {
    try {
      final db = await database;
      int result = await db.delete(
        'products',
        where: 'id = ?',
        whereArgs: [id],
      );
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> deleteAllCategories() async {
    try {
      final db = await database;
      int result = await db.delete('categories');
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> deleteAllProducts() async {
    try {
      final db = await database;
      int result = await db.delete('products');
      return result;
    } catch (e) {
      rethrow;
    }
  }
  Future<Product?> getProductById(int id) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'products',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return Product.fromMap(maps.first);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
  Future<bool> isDatabaseSeeded() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery('SELECT COUNT(*) FROM categories');
    return result.isNotEmpty && result[0]['COUNT(*)'] > 0;
  }
}

