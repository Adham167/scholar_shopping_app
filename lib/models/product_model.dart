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
  final String category;
  final double rate;

  const ProductModel({
    required this.imageurl,
    required this.name,
    required this.price,
    required this.description,
    required this.productDetails,
    required this.customerReview,
    required this.shoppingInformation,
    required this.questionAnswers,
    required this.category,
    required this.rate,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'imageurl': imageurl,
      'description': description,
      'productDetails': productDetails,
      'customerReview': customerReview,
      'shoppingInformation': shoppingInformation,
      'questionAnswers': questionAnswers.map((e) => e.toMap()).toList(),
      'category': category,
      'rate': rate,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'],
      price: map['price']?.toDouble(),
      imageurl: map['imageurl'],
      description: map['description'],
      productDetails: map['productDetails'],
      customerReview: map['customerReview'],
      shoppingInformation: map['shoppingInformation'],
      questionAnswers: List<QuestionAnswer>.from(
        map['questionAnswers']?.map((e) => QuestionAnswer.fromMap(e)),
      ),
      category: map['category'],
      rate: map['rate']?.toDouble(),
    );
  }
}
