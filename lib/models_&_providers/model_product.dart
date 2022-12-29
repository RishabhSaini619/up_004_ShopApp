// ignore_for_file: depend_on_referenced_packages, unrelated_type_equality_checks

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'model_http_exception.dart';

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

  void _setFavValue(bool newValue) {
    isProductFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(
      String userAuthenticationToken, String userAuthenticationId) async {
    final oldStatus = isProductFavorite;
    isProductFavorite = !isProductFavorite;
    notifyListeners();
    final url =
        'https://up-004-shop-app-default-rtdb.asia-southeast1.firebasedatabase.app/Favorite-Products-List/$userAuthenticationId/$productId.json?auth=$userAuthenticationToken';
    try {
      final response = await http.put(
        url,
        body: json.encode(
          {
            'Favorite Product': isProductFavorite,
          },
        ),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}

class Products with ChangeNotifier {
  final String userAuthenticationId;
  final String userAuthenticationToken;
  List<Product> _items = [];

  Products(
    this.userAuthenticationId,
    this.userAuthenticationToken,
    this._items,
  );

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

  Future<void> fetchProducts() async {
    final dataUrl =
        'https://up-004-shop-app-default-rtdb.asia-southeast1.firebasedatabase.app/Products-List.json?auth=$userAuthenticationToken';
    final favurl =
        'https://up-004-shop-app-default-rtdb.asia-southeast1.firebasedatabase.app/Favorite-Products-List/$userAuthenticationId.json?auth=$userAuthenticationToken';
    try {
      final response = await http.get(dataUrl);
      final favReponse = await http.get(favurl);
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
      final favData = jsonDecode(favReponse.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Product> extractedProductList = [];
      extractedData.forEach((
        extractedProductID,
        extractedProductData,
      ) {
        print(extractedProductData);
        extractedProductList.add(
          Product(
            productId: extractedProductID,
            productTitle: extractedProductData['Product Title'],
            productDescription: extractedProductData['Product Description'],
            productPrice: extractedProductData['Product Price'].toDouble(),
            productImageURL: extractedProductData['Product ImageURL'],
            isProductFavorite: favData == null
                ? false
                : favData['$extractedProductID Favorite Product'] ?? false,
          ),
        );
      });

      _items = extractedProductList;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(Product addedProduct) async {
    final url =
        'https://up-004-shop-app-default-rtdb.asia-southeast1.firebasedatabase.app/Products-List.json?auth=$userAuthenticationToken';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'Product Title': addedProduct.productTitle,
            'Product Description': addedProduct.productDescription,
            'Product Price': addedProduct.productPrice.toDouble(),
            'Product ImageURL': addedProduct.productImageURL,
            'Favorite Product': addedProduct.isProductFavorite,
          },
        ),
      );
      // .then((response) {
      final newProduct = Product(
        productId: json.decode(response.body)['Product Id'],
        productTitle: addedProduct.productTitle,
        productDescription: addedProduct.productDescription,
        productPrice: addedProduct.productPrice.toDouble(),
        productImageURL: addedProduct.productImageURL,
      );
      _items.add(newProduct);
      // items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      rethrow;

      // }).catchError((error) {
      //   print(error);
      //   throw error;
      // });
    }
  }

  Future<void> updateProduct(
      String updatingProductID, Product updatingProduct) async {
    final updateProductIndex = _items.indexWhere((element) {
      return element.productId == updatingProductID;
    });
    if (updateProductIndex >= 0) {
      final url =
          'https://up-004-shop-app-default-rtdb.asia-southeast1.firebasedatabase.app/Products-List/$updatingProductID.json?auth=$userAuthenticationToken';
      await http.patch(
        url,
        body: json.encode(
          {
            'Product Title': updatingProduct.productTitle,
            'Product Description': updatingProduct.productDescription,
            'Product Price': updatingProduct.productPrice.toDouble(),
            'Product ImageURL': updatingProduct.productImageURL,
            'Favorite Product': updatingProduct.isProductFavorite,
          },
        ),
      );
      _items[updateProductIndex] = updatingProduct;
      notifyListeners();
    } else {
      return;
    }
  }

  Future<void> deleteProduct(String deletingProductID) async {
    final url =
        'https://up-004-shop-app-default-rtdb.asia-southeast1.firebasedatabase.app/Products-List/$deletingProductID.json?auth=$userAuthenticationToken';
    final existingProductIndex =
        _items.indexWhere((element) => element.productId == deletingProductID);
    var existingProduct = _items[existingProductIndex];
    final response = await http.delete(url);
    _items.removeAt(existingProductIndex);
    notifyListeners();
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException("Could mot delete product.");
    }
    existingProduct = null;
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.productId == id);
  }
}
