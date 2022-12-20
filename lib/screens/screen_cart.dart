import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/widget_cart_item.dart';
import '../model/model_cart.dart' show Cart;

class CartScreen extends StatelessWidget {
  static const routeName = '/CartScreen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.cartItemCount,
              itemBuilder: (context, index) {
                return CartItemWidget(
                  cart.items.values.toList()[index].cartItemId,
                  cart.items.values.toList()[index].cartItemTitle,
                  cart.items.values.toList()[index].cartItemPrice,
                  cart.items.values.toList()[index].cartItemQuantity,
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '₹ ${cart.totalAmount}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          const MaterialStatePropertyAll<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                ,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Order',
                      style: Theme.of(context).textTheme.bodyLarge.copyWith(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
