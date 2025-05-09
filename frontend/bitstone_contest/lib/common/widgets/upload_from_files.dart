import 'package:flutter/material.dart';

class UploadFromFiles extends StatefulWidget {
  const UploadFromFiles({super.key});

  @override
  State<UploadFromFiles> createState() => _UploadFromFilesState();
}

class _UploadFromFilesState extends State<UploadFromFiles> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
          ),

          onPressed: () {},
          icon: const Icon(Icons.check, color: Colors.white),
          label: const Text(
            'Upload From Files',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
