import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/model_cart.dart';

class CartItemWidget extends StatelessWidget {
  final String cardItemId;
  final String productId;

  final String cardItemTitle;
  final double cardItemPrice;
  final int cardItemQuantity;

  const CartItemWidget(
    this.cardItemId,
    this.productId,
    this.cardItemTitle,
    this.cardItemPrice,
    this.cardItemQuantity,
  );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cardItemId),
      background: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(45),
          color: Theme.of(context).errorColor,
        ),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        shape: StadiumBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1.0,
          ),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
              maxRadius: 30,
              minRadius: 10,
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.8),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                  child: Text(
                    '₹ $cardItemPrice',
                    textAlign: TextAlign.center,

                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ),
            title: Text(
              cardItemTitle,
              textAlign: TextAlign.left,

              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Row(
              children: [
                Text(
                  'Quantity',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  ' * $cardItemQuantity',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            trailing: Text(
              'Total ₹ ${cardItemPrice * cardItemQuantity}',
              textAlign: TextAlign.center,

              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }
}
