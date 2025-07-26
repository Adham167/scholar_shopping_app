import 'package:flutter/material.dart';

class CustomTextRow extends StatelessWidget {
  const CustomTextRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Aleady have an Account ?",
          style: TextStyle(color: Colors.black),
        ),
    
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/loginscreen");
          },
          child: Text(
            "Login",
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
      ],
    );
  }
}
