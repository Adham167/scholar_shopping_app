import 'package:flutter/material.dart';
import 'package:scholar_shopping_app/models/product_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.blueAccent,
      centerTitle: true,
      title: Text(productModel.name,)));
  }
}
