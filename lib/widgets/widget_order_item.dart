import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models_&_providers/model_orders.dart';

class OrderItemWidget extends StatefulWidget {
  final OrderItem orderItemWidgetOrders;

  const OrderItemWidget(this.orderItemWidgetOrders);

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  var expandedOrderItem = false;
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
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
            side: BorderSide(
                width: 2,
                color: Theme.of(context).colorScheme.primary,
            )

        ),

        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Order Amount :-  ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '₹ ${widget.orderItemWidgetOrders.orderItemAmount}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              subtitle: Row(
                children: [
                  Text(
                    "Order Date :-  ",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    DateFormat("dd/mm/yyyy hh:mm ")
                        .format(widget.orderItemWidgetOrders.orderItemDate),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(
                  expandedOrderItem
                      ? Icons.expand_less_rounded
                      : Icons.expand_more,
                ),
                onPressed: () {
                  setState(() {
                    expandedOrderItem = !expandedOrderItem;
                  });
                },
              ),
            ),
            if (expandedOrderItem)
              Container(
                height: min(
                  widget.orderItemWidgetOrders.orderItemProducts.length * 20.0 +
                      15,
                  150,
                ),
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(10),

                child: ListView(
                  children: widget.orderItemWidgetOrders.orderItemProducts
                      .map(
                        (products) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              products.cartItemTitle,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                             " ${products.cartItemQuantity} x ₹ ${products.cartItemPrice}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
