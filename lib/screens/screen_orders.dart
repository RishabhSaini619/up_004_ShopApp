import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/OrdersScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
