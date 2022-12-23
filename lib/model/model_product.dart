import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import '../model/model_basic_data.dart';
import 'package:http/http.dart' as http;

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
  List<Product> _items = basicProductData;

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
    const url =
        'https://up-004-shop-app-default-rtdb.asia-southeast1.firebasedatabase.app/Products-List.json';
    try {
      final response = await http.get(url);
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
      final List<Product> extractedProductList = [];
      extractedData.forEach((extractedProductID, extractedProductData) {
        extractedProductList.add(
          Product(
            productId: extractedProductID,
            productTitle: extractedProductData['Product Title'],
            productDescription: extractedProductData['Product Description'],
            productPrice: extractedProductData['Product Price'],
            productImageURL: extractedProductData['Product ImageURL'],
            isProductFavorite: extractedProductData['Favorite Product'],
          ),
        );
      });

      _items = extractedProductList;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product addedProduct) async {
    const url =
        'https://up-004-shop-app-default-rtdb.asia-southeast1.firebasedatabase.app/Products-List.json';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'Product Title': addedProduct.productTitle,
            'Product Description': addedProduct.productDescription,
            'Product Price': addedProduct.productPrice,
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
        productPrice: addedProduct.productPrice,
        productImageURL: addedProduct.productImageURL,
      );
      _items.add(newProduct);
      // items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;

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
          'https://up-004-shop-app-default-rtdb.asia-southeast1.firebasedatabase.app/Products-List/$updatingProductID.json';
      await http.patch(
        url,
        body: json.encode(
          {
            'Product Title': updatingProduct.productTitle,
            'Product Description': updatingProduct.productDescription,
            'Product Price': updatingProduct.productPrice,
            'Product ImageURL': updatingProduct.productImageURL,
            'Favorite Product': updatingProduct.isProductFavorite,
          },
        ),
      );
      _items[updateProductIndex] = updatingProduct;
      notifyListeners();
    } else {
      print("Invalid updateProductIndex");
    }
  }

  void deleteProduct(String deletingProductID) {
    _items.removeWhere((element) => element.productId == deletingProductID);
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.productId == id);
  }
}
