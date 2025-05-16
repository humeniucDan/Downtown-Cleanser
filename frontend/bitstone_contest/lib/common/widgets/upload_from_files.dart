import 'dart:io';

import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadFromFiles extends StatefulWidget {
  const UploadFromFiles({super.key});

  @override
  State<UploadFromFiles> createState() => _UploadFromFilesState();
}

class _UploadFromFilesState extends State<UploadFromFiles> {
  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (returnedImage == null) return;
    setState(() {
      //_selectedImage = File(returnedImage.path);
    });

    final bytes = await returnedImage.readAsBytes();
    final tags = await readExifFromBytes(bytes);

    if (tags.containsKey('GPS GPSLatitude') &&
        tags.containsKey('GPS GPSLongitude') &&
        tags.containsKey('GPS GPSLatitudeRef') &&
        tags.containsKey('GPS GPSLongitudeRef')) {
      final latValues = tags['GPS GPSLatitude']!.values;
      final lonValues = tags['GPS GPSLongitude']!.values;

      final latRef = tags['GPS GPSLatitudeRef']!.printable;
      final lonRef = tags['GPS GPSLongitudeRef']!.printable;

      double latitude = _convertToDegrees(latValues as List);
      double longitude = _convertToDegrees(lonValues as List);

      if (latRef.trim() == 'S') latitude = -latitude;
      if (lonRef.trim() == 'W') longitude = -longitude;

      print('📍 Photo location: $latitude, $longitude');
    } else {
      print('No GPS data found in image.');
    }
  }

  double _convertToDegrees(List values) {
    double d = values[0].toDouble();
    double m = values[1].toDouble();
    double s = values[2].toDouble();
    return d + (m / 60) + (s / 3600);
  }

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
            _pickImageFromGallery();
          },
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
