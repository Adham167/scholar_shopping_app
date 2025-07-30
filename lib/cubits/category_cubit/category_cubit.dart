import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  CollectionReference categories = FirebaseFirestore.instance.collection(
    'categories',
  );
    final CollectionReference products = FirebaseFirestore.instance.collection('products');

  List<String> categoryList = [];
  void addCategory({required String categoryName}) async {
    try {
      final query =
          await categories.where("name", isEqualTo: categoryName).get();
      if (query.docs.isNotEmpty) {
        emit(CategoryFailure("Category already exists"));
        return;
      }
      await categories.add({"name": categoryName});
    } on FirebaseException catch (e) {
      emit(CategoryFailure(e.toString()));
    }
  }

  void getCategory() {
    categories.snapshots().listen((event) {
      categoryList.clear();
      for (var doc in event.docs) {
        categoryList.add(doc['name']);
      }

      emit(CategorySuccess(categories: categoryList));
    });
  }

   Future<void> deleteCategory(String categoryName) async {
    try {
      final categoryQuery = await categories.where("name", isEqualTo: categoryName).get();
      if (categoryQuery.docs.isNotEmpty) {
        await categories.doc(categoryQuery.docs.first.id).delete();
      }

      final productsQuery = await products.where("category", isEqualTo: categoryName).get();
      for (var doc in productsQuery.docs) {
        await products.doc(doc.id).delete();
      }

      categoryList.remove(categoryName);
      emit(CategorySuccess(categories: categoryList));
    } on FirebaseException catch (e) {
      emit(CategoryFailure(e.toString()));
    }
  }
  Future<int> getProductsCountByCategory(String categoryName) async {
    try {
      final query = await products.where('category', isEqualTo: categoryName).get();
      return query.docs.length;
    } on FirebaseException catch (e) {
      emit(CategoryFailure(e.toString()));
      return 0;
    }
  }
}
