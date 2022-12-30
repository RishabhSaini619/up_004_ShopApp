// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models_&_providers/model_cart.dart';
import '../models_&_providers/model_orders.dart';

import '../widgets/widget_app_drawer.dart';
import '../widgets/widget_cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/CartScreen';

  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.cartItemCount,
              itemBuilder: (context, index) {
                return CartItemWidget(
                  cart.items.values.toList()[index].cartItemId,
                  cart.items.keys.toList()[index],
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
                  const SizedBox(
                    width: 5,
                  ),
                  Chip(
                    label: Text(
                      '₹ ${cart.totalAmount.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  ),
                  const Spacer(),
                  OrderButtonWidget(cart: cart),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButtonWidget extends StatefulWidget {
  const OrderButtonWidget({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButtonWidget> createState() => _OrderButtonWidgetState();
}

class _OrderButtonWidgetState extends State<OrderButtonWidget> {
  bool _isOrderLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
      onPressed: (widget.cart.totalAmount <= 0 || _isOrderLoading)
          ? null
          : () async {
              setState(() {
                _isOrderLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
              );
              setState(() {
                _isOrderLoading = false;
              });
              widget.cart.clearCartItem();
            },
      child: _isOrderLoading
          ? CircularProgressIndicator(
              strokeWidth: 3,
              color: Theme.of(context).colorScheme.primary,
            )
          : Text(
              'Order',
              style: Theme.of(context).textTheme.bodyLarge.copyWith(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
    );
  }
}
