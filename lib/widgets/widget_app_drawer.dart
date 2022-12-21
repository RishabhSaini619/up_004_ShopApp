import 'package:flutter/material.dart';
import 'package:up_004_shopapp/screens/screen_orders.dart';
import 'package:up_004_shopapp/screens/screen_products_overview.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Hii :)"),
            centerTitle: false,
            titleTextStyle: Theme.of(context).textTheme.titleLarge,
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.shopping_bag_sharp),
            title: Text(
              "Shop",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(ProductsOverviewScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.shopping_cart_checkout_sharp),
            title: Text(
              "Orders",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(OrdersScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
