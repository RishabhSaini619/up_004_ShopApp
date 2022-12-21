import 'package:flutter/material.dart';
import 'package:up_004_shopapp/model/model_product.dart';

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
  final imageUrlFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  var addedProduct = Product(
    productId: null,
    productTitle: "",
    productDescription: "",
    productPrice: 0.0,
    productImageURL: "",
  );

  void updateProduct() {
    formKey.currentState.save();
    print(
        "productTitle  ${addedProduct.productTitle} \n productDescription ${addedProduct.productDescription}\n productImageURL ${addedProduct.productImageURL}\n productPrice ${addedProduct.productPrice}");
  }

  void updateImageUrl() {
    if (!imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void initState() {
    imageUrlFocusNode.addListener(updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    imageUrlFocusNode.removeListener(updateImageUrl);
    editedProductTitleController.dispose();
    editedProductDescriptionController.dispose();
    editedProductImageURLController.dispose();
    editedProductAmountController.dispose();
    imageUrlFocusNode.dispose();
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
            onPressed: updateProduct,
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
          key: formKey,
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
                onSaved: (value) {
                  addedProduct = Product(
                    productId: null,
                    productTitle: value,
                    productDescription: addedProduct.productDescription,
                    productPrice: addedProduct.productPrice,
                    productImageURL: addedProduct.productImageURL,
                  );
                },
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
                onSaved: (value) {
                  addedProduct = Product(
                    productId: null,
                    productTitle: addedProduct.productTitle,
                    productDescription: addedProduct.productDescription,
                    productPrice: double.parse(value).toDouble(),
                    productImageURL: addedProduct.productImageURL,
                  );
                },
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
                onSaved: (value) {
                  addedProduct = Product(
                    productId: null,
                    productTitle: addedProduct.productTitle,
                    productDescription: value,
                    productPrice: addedProduct.productPrice,
                    productImageURL: addedProduct.productImageURL,
                  );
                },
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
                              fit: BoxFit.fill,
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
                      focusNode: imageUrlFocusNode,
                      onEditingComplete: () {
                        setState(() {});
                      },
                      onFieldSubmitted: (_) {
                        updateProduct();
                      },
                      onSaved: (value) {
                        addedProduct = Product(
                          productId: null,
                          productTitle: addedProduct.productTitle,
                          productDescription: addedProduct.productDescription,
                          productPrice: addedProduct.productPrice,
                          productImageURL: value,
                        );
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
