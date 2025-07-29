import 'package:scholar_shopping_app/models/product_model.dart';

abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<ProductModel> wishlist;

  WishlistLoaded(this.wishlist);
}

class WishlistError extends WishlistState {
  final String error;

  WishlistError(this.error);
}
