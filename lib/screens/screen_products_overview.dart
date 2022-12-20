import 'package:flutter/material.dart';
import 'package:up_004_shopapp/screens/screen_cart.dart';
import '../model/model_cart.dart';
import 'package:provider/provider.dart';
import '../widgets/widget_badge.dart';
import '../widgets/widget_product_grid.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = '/ProductsOverviewScreen';

  const ProductsOverviewScreen({Key key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavoritesOnly = true;

  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context, listen:  false);
    final cartData = Provider.of<Cart>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("ENGAGE"),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorites) {
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
                value: FilterOptions.favorites,
                child: Text(
                  "Only Favorites",
                ),
              ),
              PopupMenuItem(
                value: FilterOptions.all,
                child: Text(
                  "Show All",
                ),
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cartData, consumerChild) => BadgeWidget(
              badgeChild: consumerChild,
              badgeValue: cartData.cartItemCount.toString(),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart_sharp,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: ProductGridWidget(_showFavoritesOnly),
    );
  }
}
