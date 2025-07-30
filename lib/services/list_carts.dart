import 'package:flutter/material.dart';
import 'package:scholar_shopping_app/models/cart_model.dart';
import 'package:scholar_shopping_app/models/order_model.dart';

List<CartModel> listCarts = [];

ValueNotifier<int> cartItemCountNotifier = ValueNotifier(0);

void updateCartItemCount() {
  int totalCount = 0;
  for (var item in listCarts) {
    totalCount += item.count;
  }
  cartItemCountNotifier.value = totalCount;
}

List<OrderModel> orderHistory = [];

void confirmOrder(List<CartModel> items, double totalPrice) {
  orderHistory.add(OrderModel(
    orderId: DateTime.now().millisecondsSinceEpoch.toString(),
    items: List.from(items),
    totalPrice: totalPrice,
  ));
  items.clear();
}