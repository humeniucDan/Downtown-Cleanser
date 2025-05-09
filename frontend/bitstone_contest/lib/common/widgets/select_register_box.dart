import 'package:flutter/material.dart';

class RegisterBox extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool isSelected;
  const RegisterBox({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        border:
            isSelected
                ? Border.all(color: const Color(0xFFFF3066), width: 3)
                : Border.all(color: Colors.grey),

        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 0.35 * screenWidth,
            width: double.infinity,
            child: Image.asset(imagePath),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 4),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: isSelected ? Color(0xFFFF3066) : Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Text(
              description,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: const Color.fromARGB(255, 116, 116, 116),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
