part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductSuccess extends ProductState {
  List<ProductModel> productList;
  ProductSuccess({required this.productList});
}

final class ProductFailure extends ProductState {
  String errMessage;
  ProductFailure(this.errMessage);
}
