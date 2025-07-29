import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_shopping_app/cubits/product_cubit/product_cubit.dart';
import 'package:scholar_shopping_app/widgets/show_message.dart';
import 'package:scholar_shopping_app/widgets/vertical_product_list_item.dart';

class ProductByCategory extends StatelessWidget {
  const ProductByCategory({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductCubit>(context).getProductsByCategory(name);

    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductSuccess) {
          var productslist = state.productList;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.65,
            ),
            itemCount: productslist.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: VerticalProductListItem(
                  productModel: productslist[index],
                ),
              );
            },
          );
        } else if (state is ProductFailure) {
          ShowMessage(context, state.errMessage);
          return Text(state.errMessage);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
