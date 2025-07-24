import 'package:flutter/material.dart';
import 'package:scholar_shopping_app/models/cart_model.dart';

class CardInCart extends StatefulWidget {
  const CardInCart({
    super.key,
    required this.cartModel,
    required this.onDelete,
    required this.onQuantityChanged,
  });
  final CartModel cartModel;
  final VoidCallback onDelete;
  final VoidCallback onQuantityChanged;
  @override
  State<CardInCart> createState() => _CardInCartState();
}

class _CardInCartState extends State<CardInCart> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,

        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 28.0,
                right: 16,
                left: 16,
                bottom: 28,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  widget.cartModel.image,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 150,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cartModel.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.cartModel.price.toString(),
                    style: TextStyle(color: Colors.green),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.cartModel.count--;
                          setState(() {});
                          widget.onQuantityChanged.call();
                        },

                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[300],
                          child: Icon(Icons.remove),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(widget.cartModel.count.toString()),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          widget.cartModel.count++;
                          setState(() {});
                          widget.onQuantityChanged.call();
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blueAccent,
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: widget.onDelete,
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                  Text(
                    "\$${((widget.cartModel.price) * widget.cartModel.count).toString()}",
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
