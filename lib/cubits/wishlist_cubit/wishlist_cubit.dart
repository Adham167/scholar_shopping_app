import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_shopping_app/cubits/wishlist_cubit/wishlist_state.dart';
import 'package:scholar_shopping_app/models/product_model.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial());

  final _firestore = FirebaseFirestore.instance;

  Future<void> loadWishlist(String userId) async {
    emit(WishlistLoading());
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('wishlist')
          .get();

      final products = snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data()))
          .toList();

      emit(WishlistLoaded(products));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> addToWishlist(String userId, ProductModel product) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('wishlist')
          .doc(product.name)
          .set(product.toMap());

      loadWishlist(userId); // Refresh the list
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> removeFromWishlist(String userId, String productname) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('wishlist')
          .doc(productname)
          .delete();

      loadWishlist(userId); // Refresh the list
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  bool isInWishlist(List<ProductModel> list, String productname) {
    return list.any((product) => product.name == productname);
  }
}
