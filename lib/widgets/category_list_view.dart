import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_shopping_app/cubits/category_cubit/category_cubit.dart';
import 'package:scholar_shopping_app/services/products.dart';
import 'package:scholar_shopping_app/widgets/category_list_view_item.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is CategorySuccess) {
              return Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.categories.length,
                  itemBuilder: (contex, index) {
                    final categoryName = state.categories[index];

                    return FutureBuilder<int>(
                      future: BlocProvider.of<CategoryCubit>(
                        context,
                      ).getProductsCountByCategory(categoryName),
                      builder: (context, snapshot) {
                        final count = snapshot.data ?? 0;

                        return CategoryListViewItem(
                          categoryName: state.categories[index],
                          countofProducts:
                              count,
                        );
                      },
                    );
                  },
                ),
              );
            } else if (state is CategoryFailure) {
              return Text(state.errMessage);
            } else {
              return const CircularProgressIndicator();
            }
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
                        title: const Text(
                          'Add New Category',
                          style: TextStyle(fontSize: 24),
                        ),
                        content: TextField(
                          onChanged: (data) {
                            name = data;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Add Category Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (name != null && name!.isNotEmpty) {
                                BlocProvider.of<CategoryCubit>(
                                  context,
                                ).addCategory(categoryName: name!);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Add'),
                          ),
                        ],
                      ),
                );
              },
              backgroundColor: Colors.blueAccent,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
