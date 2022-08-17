//  cart provider classs

import 'package:flutter/material.dart';
import 'package:iide_cart/models/cart.dart';

import '../models/product.dart';

class CartProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<CartPro> _cartProducts = [];
  List<CartPro> displayPro = [];
  List<CartPro> get displayProduct {
    return [...displayPro];
  }

  List<CartPro> get cartProducts {
    return [..._cartProducts];
  }

  double _totalPrice = 0.0;
  int totalItems = 0;
  int get itemCont {
    return totalItems;
  }

  double get totalPrice {
    return _totalPrice;
  }

  void addToCart(Product product) {
    // check product is already in cart
    if (_cartProducts.any((element) => element.product.id == product.id)) {
      _cartProducts
          .firstWhere((element) => element.product.id == product.id)
          .quantity++;
      _cartProducts
              .firstWhere((element) => element.product.id == product.id)
              .totalPrice =
          product.price *
              _cartProducts
                  .firstWhere((element) => element.product.id == product.id)
                  .quantity;
      // add to total price

    } else {
      _cartProducts.add(CartPro(
        product: product,
        quantity: 1,
        totalPrice: product.price,
      ));
    }
    _totalPrice += product.price;
    totalItems++;
    notifyListeners();
  }

  void removeFromCart(CartPro product) {
    _cartProducts
        .removeWhere((element) => element.product.id == product.product.id);
    _totalPrice -= product.totalPrice;
    totalItems -= product.quantity;
    notifyListeners();
  }

  void clearCart() {
    _cartProducts.clear();
    _totalPrice = 0.0;
    totalItems = 0;
    notifyListeners();
  }
}
