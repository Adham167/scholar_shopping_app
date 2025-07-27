import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  CollectionReference categories = FirebaseFirestore.instance.collection(
    'categories',
  );
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

  void deleteCategory() {
    categories.snapshots().listen((event) {
      for (var doc in event.docs) {
        categoryList.add(doc['name']);
      }

      emit(CategorySuccess(categories: categoryList));
    });
  }
}
