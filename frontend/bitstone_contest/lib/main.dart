<<<<<<< HEAD
import 'package:bitstone_contest/pages/history_page.dart';
=======
>>>>>>> 2f5e11a7356b1f0617ab9c515c118aab27e3a88a
import 'package:bitstone_contest/pages/login_page.dart';
import 'package:bitstone_contest/pages/show_issues_page.dart';
import 'package:bitstone_contest/pages/signup_selection_page.dart';
import 'package:bitstone_contest/pages/signup_company_page.dart';
import 'package:bitstone_contest/pages/signup_user_page.dart';
import 'package:bitstone_contest/services/auth_service.dart';
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
  final bool isUserLoggedIn = await AuthService().isLoggedIn();
=======
  final isUserLoggedIn = await AuthService().isLoggedIn();
>>>>>>> 2f5e11a7356b1f0617ab9c515c118aab27e3a88a

  runApp(MyApp(isLoggedIn: isUserLoggedIn));
}

class MyApp extends StatelessWidget {
<<<<<<< HEAD
  final bool? isLoggedIn;
=======
  final bool isLoggedIn;
>>>>>>> 2f5e11a7356b1f0617ab9c515c118aab27e3a88a
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
          if (isLoggedIn == false)
            '/': (context) => const LoginPage()
          else
            '/': (context) => const MapPage()
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
