// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models_&_providers/model_product.dart';

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

  bool isInIt = true;
  bool isLoading = false;

  var addedProduct = Product(
    productId: null,
    productTitle: "",
    productDescription: "",
    productPrice: 0.0,
    productImageURL: "",
  );
  var initialProductValue = {
    'productTitle': '',
    'productDescription': '',
    'productPrice': '',
    'productImageURL': '',
  };

  Future<void> addNewProduct() async {
    final isEditedValidator = formKey.currentState.validate();
    if (!isEditedValidator) {
      return;
    }
    formKey.currentState.save();
    setState(() {
      isLoading = true;
    });
    if (addedProduct.productId != null) {
      await Provider.of<Products>(
        context,
        listen: false,
      ).updateProduct(
        addedProduct.productId,
        addedProduct,
      );
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      try {
        await Provider.of<Products>(
          context,
          listen: false,
        ).addProduct(addedProduct);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
              side: BorderSide(
                color: Color(0xffff5722),
                width: 1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            alignment: Alignment.center,
            title: const Text("An error occurred!"),
            titleTextStyle: Theme.of(context).textTheme.titleLarge,
            content: Text(error.toString()),
            contentTextStyle: Theme.of(context).textTheme.bodyMedium,
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Okay',
                  style: Theme.of(context).textTheme.bodyMedium.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
            ],
          ),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }

  }

  void updateImageUrl() {
    if (!imageUrlFocusNode.hasFocus) {
      if (editedProductImageURLController.text.isEmpty ||
          (!editedProductImageURLController.text.startsWith('http') &&
              !editedProductImageURLController.text.startsWith('https'))) {
        return;
      }

      setState(() {});
    }
  }

  @override
  void initState() {
    imageUrlFocusNode.addListener(updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInIt) {
      final editingProductID =
          ModalRoute.of(context).settings.arguments as String;
      if (editingProductID != null) {
        final editingProduct = Provider.of<Products>(context, listen: false)
            .findById(editingProductID);

        addedProduct = editingProduct;
        editedProductTitleController.text = editingProduct.productTitle;
        editedProductDescriptionController.text =
            editingProduct.productDescription;
        editedProductAmountController.text =
            editingProduct.productPrice.toString();
        editedProductImageURLController.text = editingProduct.productImageURL;
      }
    }
    isInIt = false;

    super.didChangeDependencies();
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
        title: const Text("New Product"),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.save_as_sharp,
              size: 30,
            ),
            onPressed: addNewProduct,
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
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            : Form(
                key: formKey,
                child: ListView(
                  children: [
                    //ProductTitle
                    TextFormField(
                      controller: editedProductTitleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        labelText: "Title ",
                        labelStyle: Theme.of(context).textTheme.bodyLarge,
                        hintText: "Product Title ",
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                        // errorText: "Please enter valid product Title*",
                        errorStyle:
                            Theme.of(context).textTheme.bodySmall.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter product Title *';
                        }
                        return null;
                      }, //editedProductTitleValidator
                      onSaved: (value) {
                        addedProduct = Product(
                          productId: addedProduct.productId,
                          isProductFavorite: addedProduct.isProductFavorite,
                          productTitle: value,
                          productDescription: addedProduct.productDescription,
                          productPrice: addedProduct.productPrice,
                          productImageURL: addedProduct.productImageURL,
                        );
                      },
                    ),
                    const Divider(),
                    //ProductAmount
                    TextFormField(
                      controller: editedProductAmountController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        labelText: "Amount ",
                        labelStyle: Theme.of(context).textTheme.bodyLarge,
                        hintText: "Product Amount ",
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                        prefixText: "₹",
                        // errorText: "Please enter valid product Amount*",
                        errorStyle:
                            Theme.of(context).textTheme.bodySmall.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter valid product Amount *';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter valid Number *';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter Amount greater then 0 *';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        addedProduct = Product(
                          productId: addedProduct.productId,
                          isProductFavorite: addedProduct.isProductFavorite,
                          productTitle: addedProduct.productTitle,
                          productDescription: addedProduct.productDescription,
                          productPrice: double.parse(value),
                          productImageURL: addedProduct.productImageURL,
                        );
                      },
                    ),
                    const Divider(),
                    //ProductDescription
                    TextFormField(
                      controller: editedProductDescriptionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        labelText: "Description ",
                        labelStyle: Theme.of(context).textTheme.bodyLarge,
                        hintText: "Product Description ",
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                        // errorText: "Please enter valid product Description*",
                        errorStyle:
                            Theme.of(context).textTheme.bodySmall.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                      maxLines: 3,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter product Description *';
                        }
                        if (value.length < 10) {
                          return 'Should be at least 10 character long Description *';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        addedProduct = Product(
                          productId: addedProduct.productId,
                          isProductFavorite: addedProduct.isProductFavorite,
                          productTitle: addedProduct.productTitle,
                          productDescription: value,
                          productPrice: addedProduct.productPrice,
                          productImageURL: addedProduct.productImageURL,
                        );
                      },
                    ),
                    const Divider(),
                    // Product ImageURL
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 175,
                          height: 150,
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
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              labelText: "ImageURL ",
                              labelStyle: Theme.of(context).textTheme.bodyLarge,
                              hintText: "Product ImageURL ",
                              hintStyle: Theme.of(context).textTheme.bodyMedium,
                              // errorText: "Please enter valid product ImageURL*",
                              errorStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            focusNode: imageUrlFocusNode,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter product ImageURL *';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please enter valid \n product ImageURL *';
                              }
                              return null;
                            },
                            onEditingComplete: () {
                              setState(() {});
                            },
                            onFieldSubmitted: (_) {
                              addNewProduct();
                            },
                            onSaved: (value) {
                              addedProduct = Product(
                                productTitle: addedProduct.productTitle,
                                productDescription:
                                    addedProduct.productDescription,
                                productPrice: addedProduct.productPrice,
                                productImageURL: value,
                                productId: addedProduct.productId,
                                isProductFavorite:
                                    addedProduct.isProductFavorite,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              ),
      ),
    );
  }
}
