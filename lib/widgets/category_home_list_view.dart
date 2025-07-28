import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_shopping_app/cubits/category_cubit/category_cubit.dart';
import 'package:scholar_shopping_app/widgets/category_home_list_item.dart';

class CategoryHomeListView extends StatelessWidget {
  const CategoryHomeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        var categors = BlocProvider.of<CategoryCubit>(context).categoryList;

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: categors.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CategoryHomeListItem(name: categors[index]),
            );
          },
        );
      },
    );
  }
}
