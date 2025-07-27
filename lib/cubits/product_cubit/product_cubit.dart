import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:scholar_shopping_app/models/product_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  CollectionReference products = FirebaseFirestore.instance.collection(
    'products',
  );
  List<ProductModel> productList = [];
  void addProduct({required ProductModel productModel}) async {
    try {
      await products.add(productModel.toMap());
    } on FirebaseException catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }

  void getProduct() {
    products.snapshots().listen((event) {
      productList.clear();
      for (var doc in event.docs) {
        productList.add(ProductModel.fromMap(doc.data() as Map<String ,dynamic>));
      }

      emit(ProductSuccess(productList: productList));
    });
  }
}
