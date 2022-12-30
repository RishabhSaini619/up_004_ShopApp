// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models_&_providers/model_cart.dart';

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
    this.cardItemQuantity, {Key key}
  ) : super(key: key);

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
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
              side: BorderSide(
                color: Color(0xffff5722),
                width: 1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            titlePadding: const EdgeInsets.fromLTRB(20, 30, 20, 5),
            title: const Text("Are you sure?"),
            titleTextStyle: Theme.of(context).textTheme.titleLarge,
            contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
            content: const Text("You want to remove the item from the Cart?"),
            contentTextStyle: Theme.of(context).textTheme.bodyMedium,
            actionsPadding: const EdgeInsets.all(20),
            actions: [
              //no
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                    Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  'No',
                  style: Theme.of(context).textTheme.bodySmall.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              //yes
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);

                },
                child: Text(
                  'REMOVE',
                  style: Theme.of(context).textTheme.bodyMedium.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),

            ],
          ),
        );
        // Future.value(true);
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
