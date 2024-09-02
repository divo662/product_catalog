import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../models/product_models.dart';
import '../services/sharedPref/shared_preference_service.dart';
import '../sql/database_helper.dart';

class ProductProvider extends ChangeNotifier {
  final DatabaseHelper dbHelper = DatabaseHelper();
  List<Product> _products = [];
  List<Product> _allProducts = [];
  List<Category> _categories = [];
  int _selectedCategoryIndex = 0;
  final Set<int> _cartProductIds = {};
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;

  List<Product> get products => _products;

  List<Category> get categories => _categories;

  int get selectedCategoryIndex => _selectedCategoryIndex;

  String? get error => _error;

  List<int> get cartProductIds => _cartProductIds.toList();

  void setSelectedCategoryIndex(int index) {
    if (index < 0 || index > _categories.length) {
      _error = "Invalid category index.";
      return;
    }
    _selectedCategoryIndex = index;
    if (index == 0) {
      fetchProducts();
    } else {
      fetchProducts(categoryId: _categories[index - 1].id);
    }
    notifyListeners();
  }

  Future<void> fetchProducts({int? categoryId}) async {
    _setLoading(true);
    _error = null;
    try {
      if (categoryId == null) {
        _allProducts = await dbHelper.getProducts();
        _products = _allProducts;
      } else {
        _products = await dbHelper.getProducts(categoryId: categoryId);
      }
      if (_products.isEmpty) {
        _error = "No products found for the selected category.";
      }
    } catch (e) {
      _error = "Failed to fetch products: ${e.toString()}";
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _initializeData() async {
    await fetchCategories();
    await fetchProducts();
  }

  Future<void> toggleCart(int productId) async {
    try {
      if (_cartProductIds.contains(productId)) {
        _cartProductIds.remove(productId);
        await SharedPreferenceService.removeFromCart(productId);
      } else {
        _cartProductIds.add(productId);
        await SharedPreferenceService.addToCart(productId);
        if (!_allProducts.any((p) => p.id == productId)) {
          final product = await dbHelper.getProductById(productId);
          if (product != null) {
            _allProducts.add(product);
          }
        }
      }
      notifyListeners();
    } catch (e) {
      _error = "Failed to toggle cart: ${e.toString()}";
    }
  }

  Product getProductById(int productId) {
    return _allProducts.firstWhere(
      (product) => product.id == productId,
      orElse: () => throw Exception('Product not found'),
    );
  }

  Future<void> fetchCategories() async {
    _setLoading(true);
    _error = null;
    try {
      _categories = await dbHelper.getCategories();
    } catch (e) {
      _error = "Failed to fetch categories: ${e.toString()}";
    } finally {
      _setLoading(false);
    }
  }

  ProductProvider() {
    _initializeData();
  }

  Future<void> deleteProduct(int id) async {
    _setLoading(true);
    _error = null;
    try {
      await dbHelper.deleteProduct(id);
      _products.removeWhere((product) => product.id == id);
      notifyListeners();
    } catch (e) {
      _error = "Failed to delete product: ${e.toString()}";
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateProduct(Product product) async {
    _setLoading(true);
    _error = null;
    try {
      await dbHelper.updateProduct(product);
      final index = _products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        _products[index] = product;
        notifyListeners();
      }
    } catch (e) {
      _error = "Failed to update product: ${e.toString()}";
    } finally {
      _setLoading(false);
    }
  }

  String getCategoryNameById(int id) {
    try {
      return _categories.firstWhere((category) => category.id == id).name;
    } catch (e) {
      _error = "Category not found: ${e.toString()}";
      return "Unknown Category";
    }
  }

  bool isInCart(int productId) => _cartProductIds.contains(productId);

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final Map<int, int> _productQuantities = {};

  int getProductQuantity(int productId) {
    return _productQuantities[productId] ?? 1;
  }

  void increaseQuantity(int productId) {
    _productQuantities[productId] = (_productQuantities[productId] ?? 1) + 1;
    notifyListeners();
  }

  void decreaseQuantity(int productId) {
    if (_productQuantities[productId] != null &&
        _productQuantities[productId]! > 1) {
      _productQuantities[productId] = _productQuantities[productId]! - 1;
      notifyListeners();
    }
  }

  void removeFromCart(int productId) {
    _cartProductIds.remove(productId);
    _productQuantities.remove(productId);
    notifyListeners();
  }

  Future<void> searchProducts(String query) async {
    _setLoading(true);
    _error = null;
    try {
      if (query.isEmpty) {
        _products = _allProducts;
      } else {
        _products = _allProducts
            .where((product) =>
                product.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

        if (_products.isEmpty) {
          _error = "No products found matching the search query.";
        }
      }
    } catch (e) {
      _error = "Failed to search products: ${e.toString()}";
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    _setLoading(true);
    _error = null;
    try {
      int id = await dbHelper.insertProduct(product);
      product = product.copyWith(id: id);
      _products.add(product);
      notifyListeners();
    } catch (e) {
      _error = "Failed to add product: ${e.toString()}";
    } finally {
      _setLoading(false);
    }
  }
}
