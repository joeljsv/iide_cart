// cart class model

import 'package:iide_cart/models/product.dart';

class CartPro {
  Product product;
  int quantity =0;
  double totalPrice;
  CartPro({
    required this.product,
    required this.totalPrice,
    required this.quantity,
  });
}
