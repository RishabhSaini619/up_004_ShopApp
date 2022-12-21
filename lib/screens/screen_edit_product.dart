import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/EditProductScreen';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final editedProductTitleController = TextEditingController();
  final editedProductDescriptionController = TextEditingController();
  final editedProductImageURLController = TextEditingController();
  final editedProductAmountController = TextEditingController();
  @override
  void dispose() {
    editedProductTitleController.dispose();
    editedProductDescriptionController.dispose();
    editedProductImageURLController.dispose();
    editedProductAmountController.dispose();
    super.dispose();
  }

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
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
        child: Form(
          child: ListView(
            children: [
              //ProductTitle
              TextFormField(
                controller: editedProductTitleController,
                decoration: InputDecoration(
                  labelText: "Product Title ",
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
              ),

              //ProductAmount
              TextFormField(
                controller: editedProductAmountController,
                decoration: InputDecoration(
                  labelText: "Product Amount ",
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                  prefixText: "₹",
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
              ),
              //ProductDescription
              TextFormField(
                controller: editedProductDescriptionController,
                decoration: InputDecoration(
                  labelText: "Product Description ",
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                ),
                maxLines: 3,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
              ),
              // Product ImageURL
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1,
                      ),
                    ),
                    child: editedProductImageURLController.text.isEmpty
                        ? const Text(
                            "Enter Url",
                            textAlign: TextAlign.center,
                          )
                        : FittedBox(
                            child: Image.network(
                              editedProductImageURLController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: editedProductImageURLController,
                      decoration: InputDecoration(
                        labelText: "Product ImageURL ",
                        labelStyle: Theme.of(context).textTheme.bodyLarge,
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: () {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              //
            ],
          ),
        ),
      ),
    );
  }
}
