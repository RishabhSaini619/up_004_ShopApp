// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models_&_providers/model_product.dart';
import 'widget_product_item.dart';

class ProductGridWidget extends StatelessWidget {
  final bool showOnlyFavorites;

  const ProductGridWidget(this.showOnlyFavorites);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showOnlyFavorites ? productsData.favoritesItems : productsData.items;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        // create: (context) => products[index],
        child: const ProductItemWidget(
          // products[index].productId,
          // products[index].productTitle,
          // products[index].productImageURl,
        ),
      ),
      padding: const EdgeInsets.all(10),
    );
  }
}
