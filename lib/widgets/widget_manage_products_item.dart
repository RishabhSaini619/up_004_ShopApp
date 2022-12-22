import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/model_product.dart';
import '../screens/screen_edit_product.dart';

class ManageProductsItemWidget extends StatelessWidget {
  final String manageProductsItemWidgetId;
  final String manageProductsItemWidgetTitle;
  final String manageProductsItemWidgetDescription;
  final double manageProductsItemWidgetAmount;
  final String manageProductsItemWidgetImageURL;

  const ManageProductsItemWidget(
    this.manageProductsItemWidgetId,
    this.manageProductsItemWidgetTitle,
    this.manageProductsItemWidgetDescription,
    this.manageProductsItemWidgetAmount,
    this.manageProductsItemWidgetImageURL,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(45),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1,
        ),
      ),
      child: ListTile(
        title: Text(
          manageProductsItemWidgetTitle,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        leading: CircleAvatar(
          minRadius: 15,
          maxRadius: 25,
          backgroundImage: NetworkImage(manageProductsItemWidgetImageURL),
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.mode_edit_sharp,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    EditProductScreen.routeName,
                    arguments: manageProductsItemWidgetId,
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_forever_sharp,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () {
                  Provider.of<Products>(context,listen: false).deleteProduct(manageProductsItemWidgetId);

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
