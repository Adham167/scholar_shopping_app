import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.message1,
    required this.message2,
    required this.message3, required this.iconData,
  });
  final String message1;
  final String message2;
  final String message3;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Center(
          child: Opacity(
            opacity: 0.5,
            child: Icon(iconData, size: 80),
          ),
        ),
        SizedBox(height: 16),
        Opacity(
          opacity: 0.5,
          child: Text(message1, style: TextStyle(fontSize: 24)),
        ),
        SizedBox(height: 8),
        Opacity(
          opacity: 0.5,
          child: Text(message2, style: TextStyle(fontSize: 16)),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/homescreen");
          },
          child: Text(message3, style: TextStyle(color: Colors.blueAccent)),
        ),
        Spacer(),
      ],
    );
  }
}
