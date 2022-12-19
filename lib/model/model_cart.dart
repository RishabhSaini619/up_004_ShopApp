import 'package:flutter/foundation.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }
  int get cartItemCount {
    return  _items.length;
  }

  void addItem(
    String productId,
    String productTitle,
    double productPrice,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              existingCartItem.cartItemId,
              existingCartItem.cartItemTitle,
              existingCartItem.cartItemQuantity + 1,
              existingCartItem.cartItemPrice));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                DateTime.now().toString(),
                productTitle,
                4,
                productPrice,
              ));
    }
  }
  notifyListeners();
}

class CartItem {
  final String cartItemId;
  final String cartItemTitle;
  final int cartItemQuantity;
  final double cartItemPrice;

  CartItem(
    @required this.cartItemId,
    @required this.cartItemTitle,
    @required this.cartItemQuantity,
    @required this.cartItemPrice,
  );
}
