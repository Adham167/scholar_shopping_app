import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_shopping_app/cubits/product_cubit/product_cubit.dart';
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
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              BlocProvider.of<ProductCubit>(context).sortProducts(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'name',
                  child: Text('Sorting by Name'),
                ),
                const PopupMenuItem<String>(
                  value: 'price',
                  child: Text('Sorting by Price'),
                ),
                const PopupMenuItem<String>(
                  value: 'rate',
                  child: Text('Sorting by Rate'),
                ),
              ];
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ProductByCategory(name: name),
    );
  }
}
