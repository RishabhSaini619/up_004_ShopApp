// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models_&_providers/model_authentication.dart';
import '../models_&_providers/model_cart.dart';
import '../models_&_providers/model_product.dart';

import '../screens/screen_product_detail.dart';


class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({Key key}) : super(key: key);

  // final String productItemId;
  // final String productItemTitle;
  // final String productItemImageURL;
  //
  // const ProductItemWidget(
  //     this.productItemId, this.productItemTitle, this.productItemImageURL,
  //     {Key key})
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authenticationData = Provider.of<Authentication>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: GridTile(
        // header: Text(productItemId),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            product.productTitle,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          leading: Consumer<Product>(
            builder: (context, product, _) => IconButton(
              icon: Icon(
                product.isProductFavorite
                    ? Icons.favorite_sharp
                    : Icons.favorite_border_sharp,
                color: const Color(0xffff0000),
              ),
              onPressed: () {
                product.toggleFavoriteStatus(
                  authenticationData.authenticationToken,
                  authenticationData.getAuthenticationUserId
                );
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    backgroundColor: Colors.deepOrange.withOpacity(0.4),
                    // Theme.of(context).colorScheme.primary.withOpacity(0.4),
                    content: Text(
                      'Item added to Favorite',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),

                    duration: const Duration(seconds: 1),
                    action: SnackBarAction(
                      label: 'UNDO',
                      textColor: Colors.white,
                      disabledTextColor: Colors.white54,
                      onPressed: () {
                        cart.removeSelectedItem(product.productId);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              size: 20,
              color: Colors.deepOrangeAccent,
            ),
            onPressed: () {
              cart.addItem(product.productId, product.productTitle,
                  product.productPrice);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  )),
                  backgroundColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  content: Text(
                    'Item added to Cart',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  duration: const Duration(seconds: 1),
                  action: SnackBarAction(
                    label: 'UNDO',
                    textColor: Colors.white,
                    disabledTextColor: Colors.white54,
                    onPressed: () {
                      cart.removeSelectedItem(product.productId);
                    },
                  ),
                ),
              );
            },
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.productId,
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              product.productImageURL,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
