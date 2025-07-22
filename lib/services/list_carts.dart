import 'package:flutter/material.dart';
import 'package:scholar_shopping_app/models/cart_model.dart';

List<CartModel> listCarts = [];

ValueNotifier<int> cartItemCountNotifier = ValueNotifier(0);

void updateCartItemCount() {
  int totalCount = 0;
  for (var item in listCarts) {
    totalCount += item.count;
  }
  cartItemCountNotifier.value = totalCount;
}