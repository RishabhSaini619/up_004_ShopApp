import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:up_004_shopapp/screens/screen_edit_product.dart';
import '../model/model_product.dart';
import '../widgets/widget_app_drawer.dart';
import '../widgets/widget_manage_products_item.dart';

class ManageProductsScreen extends StatelessWidget {
  static const routeName = '/ManageProductsScreen';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Products"),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_sharp,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (context, index) => Column(
            children: [
              ManageProductsItemWidget(
                productsData.items[index].productTitle,
                productsData.items[index].productImageURL,
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}