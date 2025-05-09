import 'package:bitstone_contest/pages/login_page.dart';
import 'package:bitstone_contest/pages/show_issues_page.dart';
import 'package:bitstone_contest/pages/signup_selection_page.dart';
import 'package:bitstone_contest/pages/signup_company_page.dart';
import 'package:bitstone_contest/pages/signup_user_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'pages/map_page.dart';
import 'pages/camera_page.dart';
import 'package:flutter/foundation.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // This is important!
  if (!kIsWeb) {
    _cameras = await availableCameras();
  } // Load cameras BEFORE app starts
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final mobileRoutes = {
      '/map': (context) => const MapPage(),
      '/camera': (context) => CameraPage(cameras: _cameras),
    };

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Downtown Cleanser',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFFFF3066),
      ),
      initialRoute: '/',
      routes: {
        if (!kIsWeb)
          '/': (context) => const MapPage()
        else
          '/': (context) => const ReportsMap(),
        '/signup_selection': (context) => const SingupSelection(),
        '/map': (context) => const MapPage(),
        '/camera': (context) => CameraPage(cameras: _cameras),
        '/signup_user': (context) => SignupUserPage(),
        '/signup_company': (context) => SignupCompanyPage(),
      },
    );
  }
}
