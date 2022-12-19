import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/provider_product.dart';



class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/ProductDetailScreen';

  const ProductDetailScreen({Key key}) : super(key: key);
  // final String productItemTitle;
  //
  // const ProductDetailScreen( this.productItemTitle,
  //     {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productID);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.productTitle),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,

      ),
      // body: Text(),
    );
  }
}
