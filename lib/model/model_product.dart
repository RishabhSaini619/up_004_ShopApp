import 'package:flutter/foundation.dart';

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
