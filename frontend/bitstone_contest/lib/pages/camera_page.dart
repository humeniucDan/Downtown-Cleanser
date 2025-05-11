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
      appBar: AppBar(title: const Text('Take a Photo')),
      backgroundColor: Color.fromARGB(255, 245, 78, 123),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ClipRRect(
          borderRadius: BorderRadiusDirectional.circular(12),

          child:
              photoFile == null
                  ? CameraPreview(controller)
                  : Image.file(photoFile!),
        ),
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
            photoFile == null
                ? <Widget>[
                  ElevatedButton(
                    onPressed: takePhoto,
                    child: Row(
                      children: [
                        const Text("Take a photo"),
                        const Icon(Icons.camera),
                      ],
                    ),
                  ),
                ]
                : <Widget>[
                  ElevatedButton(
                    onPressed: deletePhoto,
                    child: Row(
                      children: [
                        const Text("Delete photo"),
                        const Icon(Icons.delete),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text("Send for processing"),
                                const Icon(Icons.send),
                              ],
                            ),
                  ),
                ],
      ),
    );
  }
}
