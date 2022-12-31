// ignore_for_file: depend_on_referenced_packages

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models_&_providers/model_orders.dart';

class OrderItemWidget extends StatefulWidget {
  final OrderItem orderItemWidgetOrders;

  const OrderItemWidget(this.orderItemWidgetOrders, {Key key})
      : super(key: key);

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  var expandedOrderItem = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(

      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
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
      child: AnimatedContainer(

        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(
                width: 2,
                color: Theme.of(context).colorScheme.primary,
              ),),
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
                    const Spacer(),
                    Text(
                      '₹ ${widget.orderItemWidgetOrders.orderItemAmount}',
                      style: Theme.of(context).textTheme.bodyLarge.copyWith(
                        fontSize: 18
                      ),
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
                AnimatedContainer(
                  duration : const Duration(milliseconds: 500),
                  curve: Curves.easeInCubic,
                  height: expandedOrderItem? min(
                    widget.orderItemWidgetOrders.orderItemProducts.length * 20.0 +
                        15,
                    150,
                  ): 0.0,
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
      ),
    );
  }
}
