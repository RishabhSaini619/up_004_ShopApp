import 'package:flutter/material.dart';
import 'package:up_004_shopapp/model/model_basic_data.dart';
import '../model/model_product.dart';
import '../widgets/widget_product_item.dart';

class ProductsOverviewScreen extends StatelessWidget {
  final List<Product> loadedProducts = basicProductData;

  ProductsOverviewScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ENGAGE",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 10,
        ),
        itemCount: loadedProducts.length,
        itemBuilder: (context, index) => ProductItemWidget(
          loadedProducts[index].productId,
          loadedProducts[index].productTitle,
          loadedProducts[index].productImageURl,
        ),
        padding: const EdgeInsets.all(10),
      ),
    );
  }
}
