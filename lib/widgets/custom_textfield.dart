import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  String hintText;
  final TextInputType textInputType;
  CustomTextfield({
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
