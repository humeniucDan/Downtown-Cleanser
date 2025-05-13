import 'package:flutter/material.dart';

class TakePhotoButton extends StatefulWidget {
  const TakePhotoButton({super.key});

  @override
  State<TakePhotoButton> createState() => _TakePhotoButtonState();
}

class _TakePhotoButtonState extends State<TakePhotoButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFFF3066),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
          ),

          onPressed: () {
            Navigator.pushNamed(context, '/camera');
          },
          icon: const Icon(Icons.check, color: Colors.white),
          label: const Text(
            'Take a photo',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
