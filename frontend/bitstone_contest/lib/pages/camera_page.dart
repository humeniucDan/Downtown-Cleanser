import 'dart:io';
import 'package:bitstone_contest/models/gps_data.dart';
import 'package:bitstone_contest/services/location_service.dart';
import 'package:bitstone_contest/services/photo_upload_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraPage({super.key, required this.cameras});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  File? photoFile;
  bool _isUploading = false;
  String _uploadMessage = '';

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  void initializeCamera() async {
    controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    await controller.initialize();
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void takePhoto() async {
    try {
      XFile photo = await controller.takePicture();
      setState(() {
        photoFile = File(photo.path);
      });
    } catch (e) {
      print(e);
    }
  }

  void deletePhoto() {
    setState(() {
      photoFile = null;
    });
  }

  Future<void> uploadPhoto() async {
    if (photoFile == null) return;

    setState(() {
      _isUploading = true;
      _uploadMessage = '';
    });

    try {
      final position = await LocationService.getCurrentPosition();
      final gpsData = GpsData(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      await UploadService.uploadImage(photoFile!, gpsData);
      Navigator.pushNamed(context, '/map');
      setState(() {
        _uploadMessage = 'Photo uploaded successfully!';
      });
    } catch (e) {
      setState(() {
        _uploadMessage = 'Failed to upload photo: $e';
      });
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 254, 55, 108),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 32),
            child: Image.asset("assets/logo-500x500.png", height: 200),
          ),
        ),
        elevation: 2,
      ),
      backgroundColor: Color.fromARGB(255, 245, 78, 123),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child:
                    photoFile == null
                        ? CameraPreview(controller)
                        : Image.file(photoFile!),
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (photoFile == null)
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: ElevatedButton(
                onPressed: takePhoto,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text("Take a photo"),
                    SizedBox(width: 8),
                    Icon(Icons.camera),
                  ],
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: deletePhoto,
                    child: Row(
                      children: const [
                        Text("Delete photo"),
                        SizedBox(width: 8),
                        Icon(Icons.delete),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _isUploading ? null : uploadPhoto,
                    child:
                        _isUploading
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : Row(
                              children: const [
                                Text("Send for processing"),
                                SizedBox(width: 8),
                                Icon(Icons.send),
                              ],
                            ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
