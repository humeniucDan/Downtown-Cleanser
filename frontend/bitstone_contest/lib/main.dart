import 'package:bitstone_contest/home_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'map_page.dart';
import 'camera_page.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // This is important!
  _cameras = await availableCameras(); // Load cameras BEFORE app starts
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Downtown Cleanser',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFFFF3066),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/map': (context) => const MapPage(),
        '/camera': (context) => CameraPage(cameras: _cameras),
      },
    );
  }
}
