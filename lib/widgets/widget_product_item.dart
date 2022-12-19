import 'package:flutter/material.dart';

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
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.deepOrange,
          width: 2,
        ),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(30),
        // borderRadius: const BorderRadius.only(
        //   topRight: Radius.circular(15),
        //   bottomLeft: Radius.circular(15),
        // ),
      ),
      child: ClipRRect(
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

          child: Image.network(
            productItemImageURL,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
