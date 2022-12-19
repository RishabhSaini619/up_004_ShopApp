import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/ProductDetailScreen';
  // final String productItemTitle;
  //
  // const ProductDetailScreen( this.productItemTitle,
  //     {Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context).settings.arguments as String;
    ///...
    return Scaffold(
      appBar: AppBar(
        title: const Text('title'),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
      ),
      // body: Text(),
    );
  }
}
