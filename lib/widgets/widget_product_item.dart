import 'package:flutter/material.dart';
import 'package:up_004_shopapp/screens/screen_product_detail.dart';

class ProductItemWidget extends StatelessWidget {
  final String productItemId;
  final String productItemTitle;
  final String productItemImageURL;

  const ProductItemWidget(
      this.productItemId, this.productItemTitle, this.productItemImageURL,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: GridTile(
        // header: Text(productItemId),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            productItemTitle,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          leading: IconButton(
            icon: const Icon(
              // isProductFavorite?
              Icons.favorite_sharp,
              // : Icons.favorite_border_sharp,
              color: Color(0xffff0000),
            ),
            onPressed: () {},
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              size: 20,
              color: Colors.deepOrangeAccent,
            ),
            onPressed: () {},
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,arguments: productItemId, );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              productItemImageURL,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
