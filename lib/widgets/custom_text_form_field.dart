import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,

    required this.label,
    required this.iconData,
    this.obsecureText = false,
    this.textInputType = TextInputType.text,
    this.maxline = 1, this.onChange,
  });

  final String label;
  final IconData iconData;
  final bool obsecureText;
  final TextInputType textInputType;
  final int maxline;
  final void Function(String?)? onChange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged: onChange,
        obscureText: obsecureText,
        keyboardType: textInputType,
        maxLines: maxline,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(iconData),
          border: OutlineInputBorder(),
        ),
        validator: (value) => value!.isEmpty ? 'Input filed is required' : null,
      ),
    );
  }
}
