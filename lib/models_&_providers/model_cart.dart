import 'package:flutter/foundation.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get cartItemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += (cartItem.cartItemPrice * cartItem.cartItemQuantity);
    });
    return total;
  }

  void addItem(
    String productId,
    String productTitle,
    double productPrice,
  ) {
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          cartItemId: existingCartItem.cartItemId,
          cartItemTitle: existingCartItem.cartItemTitle,
          cartItemQuantity: existingCartItem.cartItemQuantity + 1,
          cartItemPrice: existingCartItem.cartItemPrice,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          cartItemId: DateTime.now().toString(),
          cartItemTitle: productTitle,
          cartItemQuantity: 1,
          cartItemPrice: productPrice,
        ),
      );
    }
  }

  @override
  notifyListeners();

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSelectedItem(String productId) {
    if (!items.containsKey(productId)) {
      return;
    }
    if (items[productId].cartItemQuantity > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          cartItemId: existingCartItem.cartItemId,
          cartItemTitle: existingCartItem.cartItemTitle,
          cartItemQuantity: existingCartItem.cartItemQuantity - 1,
          cartItemPrice: existingCartItem.cartItemPrice,
        ),
      );
    } else {
      items.remove(productId);
    }
    notifyListeners();
  }

  void clearCartItem() {
    _items = {};
    notifyListeners();
  }
}

class CartItem {
  final String cartItemId;
  final String cartItemTitle;
  final int cartItemQuantity;
  final double cartItemPrice;

  CartItem({
    @required this.cartItemId,
    @required this.cartItemTitle,
    @required this.cartItemQuantity,
    @required this.cartItemPrice,
  });
}
