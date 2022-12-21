import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import '../model/model_basic_data.dart';

class Product with ChangeNotifier {
  final String productId;
  final String productTitle;
  final String productDescription;
  final double productPrice;
  final String productImageURL;
  bool isProductFavorite;

  Product({
    @required this.productId,
    @required this.productTitle,
    @required this.productDescription,
    @required this.productPrice,
    @required this.productImageURL,
    this.isProductFavorite = false,
  });
  void toggleFavoriteStatus() {
    isProductFavorite = !isProductFavorite;
    notifyListeners();
  }
}


class Products with ChangeNotifier {
  final List<Product> _items = basicProductData;

// var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((productItem) => productItem.isProductFavorite).toList();
    //}
    return [..._items];
  }
  List<Product> get favoritesItems {
    return _items.where((element) => element.isProductFavorite).toList();
  }

// void showFavoritesOnly() {
//   _showFavoritesOnly = true;
//   notifyListeners();
// }

// void showAll() {
//   _showFavoritesOnly = false;
//   notifyListeners();
// }

  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.productId == id);
  }
}
