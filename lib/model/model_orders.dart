import 'package:flutter/cupertino.dart';

import 'model_cart.dart';

class OrderItem {
  final String orderItemId;
  final double orderItemAmount;
  final List<CartItem> orderItemProducts;
  final DateTime orderItemDate;

  OrderItem({
    @required this.orderItemId,
    @required this.orderItemAmount,
    @required this.orderItemProducts,
    @required this.orderItemDate,
  });
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  addOrder(List<CartItem> cartProducts, double cartAmount) {
    _orders.insert(
      0,
      OrderItem(
        orderItemId: DateTime.now().toString(),
        orderItemAmount: cartAmount,
        orderItemProducts: cartProducts,
        orderItemDate: DateTime.now(),
      ),

    );
    notifyListeners();
  }
}
