import 'package:flutter/cupertino.dart';

import '../model/model_basic_data.dart';
import '../model/model_product.dart';

class Products with ChangeNotifier{
final List<Product> _items = basicProductData;
List<Product> get items {
  return [..._items];
}
void addProduct() {
  // _items.add(value);
  notifyListeners();
}
}