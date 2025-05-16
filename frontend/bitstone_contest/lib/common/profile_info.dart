import 'package:flutter/material.dart';

class ProfileInfoComponent extends StatelessWidget {
  final String description;
  final String information;
  const ProfileInfoComponent({
    super.key,
    required this.description,
    required this.information,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(description),
        Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 245, 78, 123),
            borderRadius: BorderRadiusDirectional.circular(12),
          ),
          child: Text(information),
        ),
      ],
    );
  }
}
