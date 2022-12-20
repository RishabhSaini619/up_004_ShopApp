import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/model_cart.dart';

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
                  TextButton(
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
