import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_shopping_app/cubits/category_cubit/category_cubit.dart';
import 'package:scholar_shopping_app/widgets/category_list_view_item.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            var categors = BlocProvider.of<CategoryCubit>(context).categoryList;
            return Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: categors.length,
                itemBuilder: (contex, index) {
                  return CategoryListViewItem(
                    categoryName: categors[index],
                    countofProducts: 15,
                  );
                },
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                String? name;
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: Text(
                          'Add New Category',
                          style: TextStyle(fontSize: 24),
                        ),
                        content: TextField(
                          onChanged: (data) {
                            name = data;
                          },
                          decoration: InputDecoration(
                            hintText: 'Add Category Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<CategoryCubit>(
                                context,
                              ).addCategory(categoryName: name!);
                              Navigator.pop(context);
                            },
                            child: Text('Add'),
                          ),
                        ],
                      ),
                );
              },
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
