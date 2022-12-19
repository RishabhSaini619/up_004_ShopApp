import 'package:flutter/material.dart';
import '../providers/provider_product.dart';
import 'package:provider/provider.dart';
import '../widgets/widget_product_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = '/ProductsOverviewScreen';

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavoritesOnly = true;

  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context, listen:  false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("ENGAGE"),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                }
              });
            },
            icon: const Icon(
              Icons.more_vert_sharp,
            ),
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: FilterOptions.Favorites,
                child: Text(
                  "Only Favorites",
                ),
              ),
              PopupMenuItem(
                value: FilterOptions.All,
                child: Text(
                  "Show All",
                ),
              ),
            ],
          ),
        ],
      ),
      body: ProductGridWidget(_showFavoritesOnly),
    );
  }
}
