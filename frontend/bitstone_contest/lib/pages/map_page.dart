import 'dart:async';
import 'package:bitstone_contest/common/widgets/custom_report_button.dart';
import 'package:bitstone_contest/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String? userEmail;
  final Completer<GoogleMapController> _controller = Completer();
  LocationData? currentLocation;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  StreamSubscription<LocationData>? locationSubscription;

  Future<String?> getUserNameFromToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null) return null;

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    setState(() {
      userEmail = decodedToken['email'];
    });
    ;
  }

  void getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    currentLocation = await location.getLocation();
    setState(() {});
    GoogleMapController googleMapController = await _controller.future;
    locationSubscription = location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(newLoc.latitude!, newLoc.longitude!),
            zoom: 16.0,
          ),
        ),
      );
      setState(() {});
    });
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: pos, zoom: 16)),
    );
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    getUserNameFromToken();
  }

  @override
  void dispose() {
    locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 254, 55, 108),
        title: Center(
          child: Image.asset("assets/logo-500x500.png", height: 200),
        ),
        elevation: 2,
      ),
<<<<<<< HEAD
<<<<<<<< HEAD:frontend/bitstone_contest/lib/pages/map_page.dart
      drawer: Drawer(
        backgroundColor: Colors.white,
=======
      drawer: Drawer(
>>>>>>> 98aa545 (added login functionality + sidebar menu + web map)
        width: screenSize.width * 0.65,
        child: ListView(
          children: [
            SizedBox(
              height: 150,
              child: DrawerHeader(
<<<<<<< HEAD
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 245, 78, 123),
                ),
=======
                decoration: BoxDecoration(color: Color(0xFFFF3066)),
>>>>>>> 98aa545 (added login functionality + sidebar menu + web map)
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(child: Icon(Icons.person)),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
<<<<<<< HEAD
                              userEmail ?? "Loading...",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
=======
                              ("Darius"),
                              style: TextStyle(color: Colors.white),
>>>>>>> 98aa545 (added login functionality + sidebar menu + web map)
                            ),
                            Text(
                              "Hero of the city",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
<<<<<<< HEAD
            ListTile(
              title: const Text(
                "My profile",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/report_history');
              },
              title: const Text(
                "Report History",
                style: TextStyle(color: Color.fromARGB(255, 245, 78, 123)),
              ),
            ),
            ListTile(
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                AuthService().logout();
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
========
      drawer: Drawer(width: screenSize.width * 0.60),
>>>>>>>> b130098 (added web support):frontend/lib/pages/map_page.dart
=======
            ListTile(title: const Text("Reports")),
            ListTile(title: const Text("Logout")),
          ],
        ),
      ),
>>>>>>> 98aa545 (added login functionality + sidebar menu + web map)
      body: Stack(
        children: [
          currentLocation == null
              ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Color.fromARGB(255, 167, 62, 55),
                    ),
                    Text("Loading Map..."),
                  ],
                ),
              )
              : GoogleMap(
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                cloudMapId: "3862fa5c70e57954",
                onMapCreated: (mapController) {
                  _controller.complete(mapController);
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    currentLocation!.latitude!,
                    currentLocation!.longitude!,
                  ),
                  zoom: 16.0,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId("current"),
                    icon: currentLocationIcon,
                    position: LatLng(
                      currentLocation!.latitude!,
                      currentLocation!.longitude!,
                    ),
                  ),
                },
              ),

          Column(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20.0,
                  left: 16,
                  right: 16,
                ),
                child: Center(child: ReportButton()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
