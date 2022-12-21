import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/model_orders.dart';
import '../widgets/widget_order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/OrdersScreen';

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
      ),
      body: ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (context, index) => OrderItemWidget(
          ordersData.orders[index],
        ),
      ),
    );
  }
}
