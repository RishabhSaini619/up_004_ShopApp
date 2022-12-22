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

  void addProduct(Product addedProduct) {
    final newProduct = Product(
      productId: DateTime.now().toString(),
      productTitle: addedProduct.productTitle,
      productDescription: addedProduct.productDescription,
      productPrice: addedProduct.productPrice,
      productImageURL: addedProduct.productImageURL,
    );
    _items.add(newProduct);
    // items.insert(0, newProduct);
    notifyListeners();
  }

  void updateProduct(String updatingProductID, Product updatingProduct) {
    final updateProductIndex = _items.indexWhere((element) {
      return element.productId == updatingProductID;
    });
    if (updateProductIndex >= 0) {
      _items[updateProductIndex] = updatingProduct;
      notifyListeners();
    }
    else {
      print("Invalid updateProductIndex");
    }

  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.productId == id);
  }
}
