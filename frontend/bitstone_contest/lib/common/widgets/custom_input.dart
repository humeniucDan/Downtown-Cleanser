import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final String? placeholder;
  final TextEditingController controller;

  const CustomInputField({
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: placeholder, // Placeholder text here
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(10),
          ),
        ),
      ],
    );
  }
}
