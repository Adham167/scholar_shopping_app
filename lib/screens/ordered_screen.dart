import 'package:flutter/material.dart';
import 'package:scholar_shopping_app/widgets/empty_widget.dart';

class OrderedScreen extends StatelessWidget {
  const OrderedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: Text(
          "My Orders",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: EmptyWidget(
        message1: "No Orders yet",
        message2: "Your Order History will appear here",
        message3: "Start Shopping",
        iconData: Icons.list_alt,
      ),
    );
  }
}
