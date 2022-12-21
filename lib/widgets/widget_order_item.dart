import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/model_orders.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem orderItemWidgetOrders;

  const OrderItemWidget(this.orderItemWidgetOrders);

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
                    '₹ ${orderItemWidgetOrders.orderItemAmount}',
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
                          .format(orderItemWidgetOrders.orderItemDate),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              trailing: const IconButton(
                icon: Icon(Icons.expand_more),
                // onPressed: () {} ,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
