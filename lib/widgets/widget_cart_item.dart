import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final String cardItemId;
  final String cardItemTitle;
  final double cardItemPrice;
  final int cardItemQuantity;

  CartItemWidget(
    this.cardItemId,
    this.cardItemTitle,
    this.cardItemPrice,
    this.cardItemQuantity,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
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
            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
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
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          subtitle: Text(
            'Quantity * $cardItemQuantity',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          trailing: Text(
            'Total ₹ ${cardItemPrice * cardItemQuantity}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
