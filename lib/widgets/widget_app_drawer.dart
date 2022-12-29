import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:up_004_shopapp/models_&_providers/model_authentication.dart';
import 'package:up_004_shopapp/screens/screen_authentication%20.dart';
// import 'package:up_004_shopapp/screens/screen_cart.dart';
import 'package:up_004_shopapp/screens/screen_orders.dart';
import 'package:up_004_shopapp/screens/screen_products_overview.dart';

import '../screens/screen_manage_products.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            AppBar(
              title: const Text("Hii :)"),
              centerTitle: false,
              titleTextStyle: Theme.of(context).textTheme.titleLarge,
              automaticallyImplyLeading: false,
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag_sharp),
              title: Text(
                "Shop",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(ProductsOverviewScreen.routeName);
              },
            ),
            // const Divider(),
            // ListTile(
            //   leading: const Icon(Icons.add_shopping_cart_sharp),
            //   title: Text(
            //     "Cart",
            //     style: Theme.of(context).textTheme.titleMedium,
            //   ),
            //   onTap: () {
            //     Navigator.of(context).pushReplacementNamed(CartScreen.routeName);
            //   },
            // ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.shopping_cart_checkout_sharp),
              title: Text(
                "Orders",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.edit_note_sharp),
              title: Text(
                "Manage Products",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(ManageProductsScreen.routeName);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout_sharp),
              title: Text(
                "Logout",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed(AuthenticationScreen.routeName);
                Provider.of<Authentication>(context,listen: false).userLogOut();
              },
            ),
            const Divider(),

            const Spacer(),
            Text(
              "@RishabhSaini619",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
