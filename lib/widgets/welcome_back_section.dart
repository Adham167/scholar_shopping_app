import 'package:flutter/material.dart';

class WelcomeBackSection extends StatelessWidget {
  const WelcomeBackSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.shopping_bag, color: Colors.blueAccent, size: 60),
        SizedBox(height: 16),
        Text(
          "Welcome Back!",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        SizedBox(height: 12),
        Opacity(
          opacity: 0.5,
          child: Text(
            "Sign in to continue shopping",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
