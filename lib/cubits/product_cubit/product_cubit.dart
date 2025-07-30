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
  void getProductsByCategory(String categoryName) {
  products
      .where('category', isEqualTo: categoryName)
      .snapshots()
      .listen((event) {
    productList.clear();
    for (var doc in event.docs) {
      productList.add(ProductModel.fromMap(doc.data() as Map<String, dynamic>));
    }
    emit(ProductSuccess(productList: productList));
  });
}

void deleteProductByName(String productName) async {
  try {
    
    final query = await products.where('name', isEqualTo: productName).get();
    for (var doc in query.docs) {
      await doc.reference.delete();
    }
  } on FirebaseException catch (e) {
    emit(ProductFailure(e.toString()));
  }
}

void sortProducts(String sortBy) {
  if (productList.isEmpty) return;
  
  switch (sortBy) {
    case 'name':
      productList.sort((a, b) => a.name.compareTo(b.name));
      break;
    case 'price':
      productList.sort((a, b) => a.price.compareTo(b.price));
      break;
    case 'rate':
      productList.sort((a, b) => b.rate.compareTo(a.rate));
      break;
  }
  
  emit(ProductSuccess(productList: productList));
}
}
