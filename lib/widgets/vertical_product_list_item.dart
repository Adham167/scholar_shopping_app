import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_shopping_app/cubits/wishlist_cubit/wishlist_cubit.dart';
import 'package:scholar_shopping_app/cubits/wishlist_cubit/wishlist_state.dart';
import 'package:scholar_shopping_app/models/cart_model.dart';
import 'package:scholar_shopping_app/models/product_model.dart';
import 'package:scholar_shopping_app/services/list_carts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerticalProductListItem extends StatelessWidget {
  const VerticalProductListItem({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final wishlistState = context.watch<WishlistCubit>().state;

    final isInWishlist =
        wishlistState is WishlistLoaded &&
        wishlistState.wishlist.any((item) => item.name == productModel.name);

    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                    ),
                    child: Image.network(
                      productModel.imageurl,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: IconButton(
                      icon: Icon(
                        isInWishlist ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        if (isInWishlist) {
                          BlocProvider.of<WishlistCubit>(
                            context,
                          ).removeFromWishlist(userId, productModel.name);
                        } else {
                          BlocProvider.of<WishlistCubit>(
                            context,
                          ).addToWishlist(userId, productModel);
                        }
                        BlocProvider.of<WishlistCubit>(
                          context,
                        ).loadWishlist(userId);
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  productModel.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    SizedBox(width: 3),
                    Text(
                      productModel.rate.toString(),
                      style: const TextStyle(fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '\$${productModel.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        final item = CartModel(
                          1,
                          price: productModel.price,
                          name: productModel.name,
                          image: productModel.imageurl,
                        );

                        listCarts.add(item);
                        updateCartItemCount();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text("Added to cart"),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.add_shopping_cart_outlined,
                        size: 20,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
