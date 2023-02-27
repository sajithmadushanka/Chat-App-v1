import 'package:flutter/material.dart';

class MyTextFiled extends StatelessWidget {
  final String? textfieldName;
  final TextEditingController controller;
  const MyTextFiled(
      {super.key, required this.textfieldName, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: textfieldName,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
  }
}
