import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_shopping_app/cubits/wishlist_cubit/wishlist_cubit.dart';
import 'package:scholar_shopping_app/cubits/wishlist_cubit/wishlist_state.dart';
import 'package:scholar_shopping_app/models/cart_model.dart';
import 'package:scholar_shopping_app/services/list_carts.dart';
import 'package:scholar_shopping_app/widgets/empty_widget.dart';
import 'package:scholar_shopping_app/widgets/vertical_product_list_item.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    BlocProvider.of<WishlistCubit>(context).loadWishlist(userId);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        title: const Text("Wishlist", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        actions: [
          PopupMenuButton<String>(
            color: Colors.white,
            onSelected: (value) {
              if (value == 'add_all') {
                final wishlistState =
                    BlocProvider.of<WishlistCubit>(context).state;
                if (wishlistState is WishlistLoaded) {
                  for (var product in wishlistState.wishlist) {
                    final item = CartModel(
                      1, // quantity
                      price: product.price,
                      name: product.name,
                      image: product.imageurl,
                    );
                    listCarts.add(item);
                  }
                  updateCartItemCount();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                        "Added ${wishlistState.wishlist.length} items to cart",
                      ),
                    ),
                  );
                }
                BlocProvider.of<WishlistCubit>(
                  context,
                ).clearWishlist(FirebaseAuth.instance.currentUser!.uid);
              } else if (value == 'remove_all') {
                BlocProvider.of<WishlistCubit>(
                  context,
                ).clearWishlist(FirebaseAuth.instance.currentUser!.uid);
              }
            },
            itemBuilder:
                (context) => [
                  const PopupMenuItem(
                    value: 'add_all',
                    child: Text('Add all to cart'),
                  ),
                  const PopupMenuItem(
                    value: 'remove_all',
                    child: Text('Remove all'),
                  ),
                ],
          ),
        ],
      ),
      body: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WishlistLoaded) {
            final wishlistProducts = state.wishlist;

            if (wishlistProducts.isEmpty) {
              return const Center(
                child: EmptyWidget(
                  message1: "No Wish List Yet",
                  message2: "Your Wish list History will appear here",
                  message3: "Start Shopping",
                  iconData: Icons.favorite_outline_outlined,
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
