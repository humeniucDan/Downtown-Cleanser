import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraPage({super.key, required this.cameras});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  File? photoFile;

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

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Take a Photo')),
      body:
          photoFile == null
              ? CameraPreview(controller)
              : Image.file(photoFile!),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children:
            photoFile == null
                ? <Widget>[
                  FloatingActionButton(
                    onPressed: takePhoto,
                    child: const Icon(Icons.camera),
                  ),
                ]
                : <Widget>[
                  FloatingActionButton(
                    onPressed: deletePhoto,
                    child: Icon(Icons.delete),
                  ),
                ],
      ),
    );
  }
}
