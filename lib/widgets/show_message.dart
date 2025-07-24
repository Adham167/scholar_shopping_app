import 'package:flutter/material.dart';

void ShowMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 3),
      backgroundColor: Colors.green,
      content: Text(message),
    ),
  );
}
