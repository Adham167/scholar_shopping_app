// في ملف جديد order_model.dart
import 'package:scholar_shopping_app/models/cart_model.dart';

class OrderModel {
  final String orderId;
  final DateTime orderDate;
  final List<CartModel> items;
  final double totalPrice;

  OrderModel({
    required this.orderId,
    required this.items,
    required this.totalPrice,
  }) : orderDate = DateTime.now();

  String get formattedDate => '${orderDate.day}/${orderDate.month}/${orderDate.year}';
}