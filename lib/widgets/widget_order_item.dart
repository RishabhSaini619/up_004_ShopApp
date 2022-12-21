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
              title: Text(
                '₹ ${orderItemWidgetOrders.orderItemAmount}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              subtitle: Text(
                DateFormat("dd MM yyyy hh:mm:ss")
                    .format(orderItemWidgetOrders.orderItemDate),
                style: Theme.of(context).textTheme.bodyMedium,
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
