import 'package:scholar_shopping_app/models/question_answer.dart';

class ProductModel {
  final String name;
  final double price;
  final String imageurl;
  final String description;
  final String productDetails;
  final String customerReview;
  final List<QuestionAnswer> questionAnswers;
  final String shoppingInformation;

  const ProductModel({
    required this.imageurl,
    required this.name,
    required this.price,
    required this.description,
    required this.productDetails,
    required this.customerReview,
    required this.shoppingInformation,
    required this.questionAnswers,
  });
}
