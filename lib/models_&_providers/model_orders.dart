import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
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
  final String userAuthenticationToken;
  List<OrderItem> _orders = [];

  Orders(this.userAuthenticationToken,this._orders);
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchOrder() async {
    final url =
        'https://up-004-shop-app-default-rtdb.asia-southeast1.firebasedatabase.app/Orders-List.json?auth=$userAuthenticationToken';
    final response = await http.get(url);
    final List<OrderItem> extractedOrderList = [];
    final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((
      extractedOrderID,
      extractedOrderData,
    ) {
      extractedOrderList.add(
        OrderItem(
          orderItemId: extractedOrderID,
          orderItemAmount: extractedOrderData['Order Amount'],
          orderItemDate: DateTime.parse(extractedOrderData['Order Date']),
          orderItemProducts:
              (extractedOrderData['Order Products'] as List<dynamic>)
                  .map(
                    (item) => CartItem(
                      cartItemId: item['Product Id'],
                      cartItemTitle:  item['Product Title'],
                      cartItemPrice: item['Product Price'].toDouble(),
                      cartItemQuantity: item['Product Quantity'],
                    ),
                  )
                  .toList(),
        ),
      );
    });
    _orders = extractedOrderList.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double cartAmount) async {
    final url =
        'https://up-004-shop-app-default-rtdb.asia-southeast1.firebasedatabase.app/Orders-List.json?auth=$userAuthenticationToken';
    final currentTimeStamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'Order Amount': cartAmount,
        'Order Date': currentTimeStamp.toIso8601String(),
        'Order Products': cartProducts
            .map((cp) => {
                  'Product Id': cp.cartItemId,
                  'Product Title': cp.cartItemTitle,
                  'Product Quantity': cp.cartItemQuantity,
                  'Product Price': cp.cartItemPrice,
                })
            .toList(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        orderItemId: json.decode(response.body)['Order Name'],
        orderItemAmount: cartAmount,
        orderItemProducts: cartProducts,
        orderItemDate: currentTimeStamp,
      ),
    );
    notifyListeners();
  }
}
