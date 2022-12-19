import 'package:flutter/material.dart';
import '../widgets/widget_product_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  static const routeName = '/ProductsOverviewScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ENGAGE"
        ),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
      ),
      body: ProductGridWidget(),
    );
  }
}


