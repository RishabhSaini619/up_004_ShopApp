// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:up_004_shopapp/screens/screen_edit_product.dart';
import '../models_&_providers/model_product.dart';
import '../widgets/widget_app_drawer.dart';
import '../widgets/widget_manage_products_item.dart';

class ManageProductsScreen extends StatelessWidget {
  static const routeName = '/ManageProductsScreen';

  const ManageProductsScreen({Key key}) : super(key: key);

  Future<void> refreshingProducts(BuildContext context) async {
    await Provider.of<Products>(
      context,
      listen: false,
    ).fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context);
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
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: refreshingProducts(context),
        builder: (context, builderData) =>
            builderData.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () => refreshingProducts(context),
                    child: Consumer<Products>(
                      builder: (context, productsData, _) => Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                          itemCount: productsData.items.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              ManageProductsItemWidget(
                                productsData.items[index].productId,
                                productsData.items[index].productTitle,
                                productsData.items[index].productDescription,
                                productsData.items[index].productPrice,
                                productsData.items[index].productImageURL,
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
