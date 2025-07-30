import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_shopping_app/cubits/category_cubit/category_cubit.dart';

class CategoryListViewItem extends StatelessWidget {
  const CategoryListViewItem({
    super.key,
    required this.categoryName,
    required this.countofProducts,
  });
  final String categoryName;
  final int countofProducts;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Text(
            categoryName[0].toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        title: Text(
          categoryName,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(" $countofProducts Product"),
        trailing: IconButton(
          onPressed: () {
            BlocProvider.of<CategoryCubit>(context).deleteCategory(categoryName);
          },
          icon: Icon(Icons.delete_outline_sharp, color: Colors.red),
        ),
      ),
    );
  }
}
