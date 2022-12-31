// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models_&_providers/model_product.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/ProductDetailScreen';

  const ProductDetailScreen({Key key}) : super(key: key);
  // final String productItemTitle;
  // const ProductDetailScreen( this.productItemTitle,
  //     {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final product = Provider.of<Product>(context, listen: false);
    // final cart = Provider.of<Cart>(context, listen: false);

    final productID = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productID);
    Widget containerWidget(Widget containerWidget, double borderWidth) {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(45),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: borderWidth,
          ),
        ),
        child: containerWidget,
      );
    }

    Widget containerChildWidget(String containerText, String containerSubText) {
      return containerWidget(
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              containerText,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            Text(
              containerSubText,
              textAlign: TextAlign.center,
              maxLines: 3,
              softWrap: true,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        2,
      );
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(loadedProduct.productTitle),
      //   titleTextStyle: Theme.of(context).textTheme.titleLarge,
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white60,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 0.5,
                  ),
                ),
                child: Text(
                  loadedProduct.productTitle,
                  style: Theme.of(context).textTheme.titleLarge.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
              ),
              background: Container(
                height: 450,
                width: double.infinity,
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(30),
                  // border: Border.all(
                  //   color: Theme.of(context).colorScheme.primary,
                  //   width: 1,
                  // ),
                ),
                child: Hero(
                  tag: loadedProduct.productId,
                  child: Image.network(
                    loadedProduct.productImageURL,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                containerChildWidget(
                    'Price ', '₹ ${loadedProduct.productPrice}'),
                const SizedBox(height: 10),
                containerChildWidget(
                    'Description ', loadedProduct.productDescription),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//{
// body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 400,
//             flexibleSpace: Container(
//               height: 450,
//               width: double.infinity,
//               margin: const EdgeInsets.all(5),
//               padding: const EdgeInsets.all(5),
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.circular(30),
//                 // border: Border.all(
//                 //   color: Theme.of(context).colorScheme.primary,
//                 //   width: 1,
//                 // ),
//               ),
//               child: Hero(
//                 tag: loadedProduct.productId,
//                 child: Image.network(
//                   loadedProduct.productImageURL,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//             // centerTitle: true,
//             title: Text(loadedProduct.productTitle),
//             titleTextStyle: Theme.of(context).textTheme.titleLarge.copyWith(
//                   color: Theme.of(context).colorScheme.secondary,
//                 ),
//           ),
//           SliverList(
//             delegate: SliverChildListDelegate(
//               [
//                 containerChildWidget(
//                     'Price ', '₹ ${loadedProduct.productPrice}'),
//                 const SizedBox(height: 10),
//                 containerChildWidget(
//                     'Description ', loadedProduct.productDescription),
//               ],
//             ),
//           ),
//         ],
//       ),
//       }

//{body: SingleChildScrollView(
//         child: containerWidget(
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 height: 400,
//                 width: double.infinity,
//                 margin: const EdgeInsets.all(5),
//                 padding: const EdgeInsets.all(5),
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   shape: BoxShape.rectangle,
//                   borderRadius: BorderRadius.circular(45),
//                   border: Border.all(
//                     color: Theme.of(context).colorScheme.primary,
//                     width: 2,
//                   ),
//                 ),
//                 child: Hero(
//                   tag: loadedProduct.productId,
//                   child: Image.network(
//                     loadedProduct.productImageURL,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               containerChildWidget('Price ', '₹ ${loadedProduct.productPrice}'),
//               const SizedBox(height: 10),
//               containerChildWidget(
//                   'Description ', loadedProduct.productDescription),
//             ],
//           ),
//           1,
//         ),
//       ),}
