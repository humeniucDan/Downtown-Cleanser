<<<<<<< HEAD:frontend/bitstone_contest/lib/main.dart
import 'package:bitstone_contest/pages/history_page.dart';
=======
>>>>>>> b130098 (added web support):frontend/lib/main.dart
import 'package:bitstone_contest/pages/login_page.dart';
import 'package:bitstone_contest/pages/show_issues_page.dart';
import 'package:bitstone_contest/pages/signup_selection_page.dart';
import 'package:bitstone_contest/pages/signup_company_page.dart';
import 'package:bitstone_contest/pages/signup_user_page.dart';
<<<<<<< HEAD
<<<<<<< HEAD:frontend/bitstone_contest/lib/main.dart
import 'package:bitstone_contest/services/auth_service.dart';
=======
>>>>>>> b130098 (added web support):frontend/lib/main.dart
=======
import 'package:bitstone_contest/services/auth_service.dart';
>>>>>>> 98aa545 (added login functionality + sidebar menu + web map)
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
<<<<<<< HEAD
<<<<<<< HEAD:frontend/bitstone_contest/lib/main.dart

  final bool isUserLoggedIn = await AuthService().isLoggedIn();

  runApp(MyApp(isLoggedIn: isUserLoggedIn));
=======
  runApp(const MyApp());
>>>>>>> b130098 (added web support):frontend/lib/main.dart
}

class MyApp extends StatelessWidget {
  final bool? isLoggedIn;
=======

  final isUserLoggedIn = await AuthService().isLoggedIn();

  runApp(MyApp(isLoggedIn: isUserLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
>>>>>>> 98aa545 (added login functionality + sidebar menu + web map)
  const MyApp({super.key, required this.isLoggedIn});

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
<<<<<<< HEAD
<<<<<<< HEAD:frontend/bitstone_contest/lib/main.dart
=======
>>>>>>> 98aa545 (added login functionality + sidebar menu + web map)
          if (isLoggedIn == false)
            '/': (context) => const LoginPage()
          else
            '/': (context) => const MapPage()
<<<<<<< HEAD
=======
          '/': (context) => const MapPage()
>>>>>>> b130098 (added web support):frontend/lib/main.dart
=======
>>>>>>> 98aa545 (added login functionality + sidebar menu + web map)
        else
          '/': (context) => const ReportsMap(),
        '/signup_selection': (context) => const SingupSelection(),
        '/map': (context) => const MapPage(),
        '/camera': (context) => CameraPage(cameras: _cameras),
        '/signup_user': (context) => SignupUserPage(),
        '/signup_company': (context) => SignupCompanyPage(),
        '/report_history': (context) => HistoryPage(),
      },
    );
  }
}
