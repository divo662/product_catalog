import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favorites') ?? [];
  }

  static Future<void> toggleFavorite(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];

    if (favorites.contains(productId.toString())) {
      favorites.remove(productId.toString());
    } else {
      favorites.add(productId.toString());
    }

    await prefs.setStringList('favorites', favorites);
  }

  static Future<List<String>> getCart() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('cart') ?? [];
  }

  static Future<void> addToCart(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList('cart') ?? [];

    if (!cart.contains(productId.toString())) {
      cart.add(productId.toString());
      await prefs.setStringList('cart', cart);
    }
  }

  static Future<void> removeFromCart(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList('cart') ?? [];

    if (cart.contains(productId.toString())) {
      cart.remove(productId.toString());
      await prefs.setStringList('cart', cart);
    }
  }
}
