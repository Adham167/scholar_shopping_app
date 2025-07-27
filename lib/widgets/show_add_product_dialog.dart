import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_shopping_app/cubits/product_cubit/product_cubit.dart';
import 'package:scholar_shopping_app/models/product_model.dart';

void showAddProductDialog(BuildContext context) {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final imageUrlController = TextEditingController();
  final descriptionController = TextEditingController();
  final detailsController = TextEditingController();
  final reviewController = TextEditingController();
  final shoppingInfoController = TextEditingController();
  final categoryController = TextEditingController();
  final rateController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Add Product"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: "Price"),
              ),
              TextField(
                controller: imageUrlController,
                decoration: InputDecoration(labelText: "Image URL"),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),
              TextField(
                controller: detailsController,
                decoration: InputDecoration(labelText: "Product Details"),
              ),
              TextField(
                controller: reviewController,
                decoration: InputDecoration(labelText: "Customer Review"),
              ),
              TextField(
                controller: shoppingInfoController,
                decoration: InputDecoration(labelText: "Shopping Info"),
              ),
              TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: "Category"),
              ),
              TextField(
                controller: rateController,
                decoration: InputDecoration(labelText: "Rate"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final product = ProductModel(
                name: nameController.text,
                price: double.parse(priceController.text),
                imageurl: imageUrlController.text,
                description: descriptionController.text,
                productDetails: detailsController.text,
                customerReview: reviewController.text,
                shoppingInformation: shoppingInfoController.text,
                category: categoryController.text,
                rate: double.parse(rateController.text),
                questionAnswers: [],
              );

              BlocProvider.of<ProductCubit>(
                context,
              ).addProduct(productModel: product);
              Navigator.pop(context);
            },
            child: Text("Add"),
          ),
        ],
      );
    },
  );
}
