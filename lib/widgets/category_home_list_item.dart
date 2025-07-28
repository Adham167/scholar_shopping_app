import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_shopping_app/cubits/product_cubit/product_cubit.dart';
import 'package:scholar_shopping_app/screens/product_by_category_screen.dart';
import 'package:scholar_shopping_app/widgets/product_by_category.dart';

class CategoryHomeListItem extends StatelessWidget {
  const CategoryHomeListItem({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ProductCubit>(context).getProductsByCategory(name);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProductByCategoryScreen(name: name);
            },
          ),
        );
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
