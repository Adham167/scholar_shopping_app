import 'package:flutter/material.dart';
import 'package:scholar_shopping_app/widgets/category_home_list_item.dart';

class CategoryHomeListView extends StatelessWidget {
  const CategoryHomeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 15,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CategoryHomeListItem(),
        );
      },
    );
  }
}
