import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/provider_product.dart';
import 'widget_product_item.dart';

class ProductGridWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) => ChangeNotifierProvider(
        create: (context) => products[index],
        child: ProductItemWidget(
          // products[index].productId,
          // products[index].productTitle,
          // products[index].productImageURl,
        ),
      ),
      padding: const EdgeInsets.all(10),
    );
  }
}
