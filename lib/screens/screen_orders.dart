import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/model_orders.dart';
import '../widgets/widget_app_drawer.dart';
import '../widgets/widget_order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrdersScreen';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isExtracting = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      setState(() {
        _isExtracting = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchOrder();
      setState(() {
        _isExtracting = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
      ),
      drawer: AppDrawer(),
      body: _isExtracting
          ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : ListView.builder(
              itemCount: ordersData.orders.length,
              itemBuilder: (context, index) => OrderItemWidget(
                ordersData.orders[index],
              ),
            ),
    );
  }
}
