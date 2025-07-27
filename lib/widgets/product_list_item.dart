import 'package:flutter/material.dart';
import 'package:scholar_shopping_app/models/product_model.dart';
import 'package:scholar_shopping_app/widgets/vertical_product_list_item.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            child: Image.network(
              productModel.imageurl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              productModel.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                SizedBox(width: 3),
                Text(
                  productModel.rate.toString(),
                  style: const TextStyle(fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '\$${productModel.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Spacer(),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
