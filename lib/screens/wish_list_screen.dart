import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_shopping_app/cubits/wishlist_cubit/wishlist_cubit.dart';
import 'package:scholar_shopping_app/cubits/wishlist_cubit/wishlist_state.dart';
import 'package:scholar_shopping_app/widgets/product_list_item.dart';
import 'package:scholar_shopping_app/widgets/vertical_product_list_item.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        title: const Text("Wishlist", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WishlistLoaded) {
            final wishlistProducts =
                state.wishlist; // دي لازم تكون List<ProductModel>

            if (wishlistProducts.isEmpty) {
              return const Center(
                child: Text(
                  "Your wishlist is empty 😕",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.6,
              ),
              itemCount: wishlistProducts.length,
              itemBuilder: (context, index) {
                return VerticalProductListItem(
                  productModel: wishlistProducts[index],
                );
              },
            );
          } else if (state is WishlistError) {
            return Center(
              child: Text(
                "Error loading wishlist: ${state.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const SizedBox(); // WishlistInitial or unknown state
          }
        },
      ),
    );
  }
}
