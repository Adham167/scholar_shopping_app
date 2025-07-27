part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryFailure extends CategoryState {
  String errMessage;
  CategoryFailure(this.errMessage);
}

final class CategorySuccess extends CategoryState {
  List<String> categories;
  CategorySuccess({required this.categories});
}

