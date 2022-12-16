import 'package:flutter/foundation.dart';

class Product {
  final String productId;
  final String productTitle;
  final String productDescription;
  final double productPrice;
  final String productImageURl;
  bool isProductFavorite;

  Product({
    @required this.productId,
    @required this.productTitle,
    @required this.productDescription,
    @required this.productPrice,
    @required this.productImageURl,
    this.isProductFavorite = false,
  });
}
