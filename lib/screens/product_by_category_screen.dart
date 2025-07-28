import 'package:flutter/material.dart';
import 'package:scholar_shopping_app/widgets/product_by_category.dart';

class ProductByCategoryScreen extends StatelessWidget {
  const ProductByCategoryScreen({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: Text(name, style: TextStyle(color: Colors.white)),
      ),
      body: ProductByCategory(name: name),
    );
  }
}
