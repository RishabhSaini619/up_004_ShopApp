// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models_&_providers/model_orders.dart';
import '../widgets/widget_app_drawer.dart';
import '../widgets/widget_order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrdersScreen';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future _ordersFuture;
  Future _obtainOrdersFuture() {
   return _ordersFuture = Provider.of<Orders>(context, listen: false).fetchOrder();
  }
  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print('building orders');
    // final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text(
                  'An error occurred!',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, ordersData, child) => ListView.builder(
                  itemCount: ordersData.orders.length,
                  itemBuilder: (context, index) => OrderItemWidget(
                    ordersData.orders[index],
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
