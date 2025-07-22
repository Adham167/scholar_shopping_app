import 'package:flutter/material.dart';
import 'package:scholar_shopping_app/models/cart_model.dart';
import 'package:scholar_shopping_app/services/list_carts.dart';
import 'package:scholar_shopping_app/widgets/card_in_cart.dart';
import 'package:scholar_shopping_app/widgets/empty_widget.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  double getTotalPrice() {
    double total = 0.0;
    for (var item in listCarts) {
      total += item.price * item.count;
    }
    return total;
  }

  int getTotalCount() {
    int count = 0;
    for (var item in listCarts) {
      count += item.count;
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Shopping Cart", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body:
          listCarts.isEmpty
              ? EmptyWidget(
                iconData: Icons.shopping_cart_outlined,
                message1: "Your Cart is Empty",
                message2: "Add some products to get started ",
                message3: "Contunu Shopping",
              )
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: listCarts.length,
                      itemBuilder: (context, index) {
                        return CardInCart(
                          onQuantityChanged: () {
                            setState(() {});
                          },
                          onDelete: () {
                            listCarts.removeAt(index);
                            setState(() {});
                          },
                          cartModel: listCarts[index],
                        );
                      },
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Text("Total Item: "),
                              Spacer(),
                              Text(
                                getTotalCount().toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Total Amount: ",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '\$${getTotalPrice().toString()}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(16),
                            ),

                            child: Center(
                              child: Text(
                                "Place Order",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
