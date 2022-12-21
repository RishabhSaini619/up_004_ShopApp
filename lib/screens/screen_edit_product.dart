import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/EditProductScreen';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Products"),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.save_as_sharp,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditProductScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(45),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
        child: Form(
          child: Column(
            children: [
              //Product Title
              ListTile(
                leading: Text(
                  "Product Title ",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                title: TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,

                ),
              ),
              //Product Description
              ListTile(
                leading: Text(
                  "Product Description ",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                title: TextFormField(
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,


                ),
              ),
              //Product ImageURL
              ListTile(
                leading: Text(
                  "Product ImageURL ",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                title: TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,

                ),
              ),
              //Product Amount
              ListTile(
                leading: Text(
                  "Product Amount",
                  style: Theme.of(context).textTheme.bodyLarge,

                ),
                title: TextFormField(
                  decoration: const InputDecoration(
                    prefixText: "₹",
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
