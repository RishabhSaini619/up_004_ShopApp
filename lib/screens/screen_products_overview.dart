import 'package:flutter/material.dart';
import '../screens/screen_cart.dart';
import '../widgets/widget_app_drawer.dart';
import '../model/model_cart.dart';
import 'package:provider/provider.dart';
import '../model/model_product.dart';
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
  var _showFavoritesOnly = false;
  var _init = true;
  bool _isExtracting = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchProducts();   // this will not work show error!
    // Future.delayed(Duration.zero).then(
    //   (value) => Provider.of<Products>(context).fetchProducts(),
    // );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_init) {
      setState(() {
        _isExtracting = true;
      });
      Provider.of<Products>(context).fetchProducts().then((_) {
        setState(() {
          _isExtracting = false;
        });
      });
    }
    _init = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
      drawer: AppDrawer(),
      body: _isExtracting
          ? Center(
        child: CircularProgressIndicator(
          strokeWidth: 3,
          color: Theme.of(context).colorScheme.primary,
        ),
      )
          : ProductGridWidget(_showFavoritesOnly),
    );
  }
}
