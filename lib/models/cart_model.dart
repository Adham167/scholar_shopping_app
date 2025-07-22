class CartModel {
  final double price;
  final String name;
  final String image;
 int count = 1;

  CartModel(this.count, {required this.price, required this.name, required this.image});
}
