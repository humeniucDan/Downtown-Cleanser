import 'dart:async';

import 'package:bitstone_contest/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ReportsMap extends StatefulWidget {
  const ReportsMap({super.key});

  @override
  State<ReportsMap> createState() => _ReportsMapState();
}

class _ReportsMapState extends State<ReportsMap> {
  final Completer<GoogleMapController> _controller = Completer();
  LocationData? currentLocation;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void getInitialLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied
      return;
    }

    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      currentLocation = LocationData.fromMap({
        "latitude": position.latitude,
        "longitude": position.longitude,
      });
    });

    final controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 16.0,
        ),
      ),
    );
  }

  String? _mapStyle;

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.json').then((string) {
      _mapStyle = string;
    });
    getInitialLocation();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 254, 55, 108),
        title: Center(
          child: Image.asset("assets/logo-500x500.png", height: 200),
        ),
        elevation: 2,
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        width: screenSize.width * 0.65,
        child: ListView(
          children: [
            SizedBox(
              height: 150,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 245, 78, 123),
                ),
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
                              "Loading...",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
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
            ListTile(
              title: const Text(
                "My profile",
                style: TextStyle(color: Color.fromARGB(255, 245, 78, 123)),
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
                style: TextStyle(color: Color.fromARGB(255, 245, 78, 123)),
              ),
              onTap: () {
                AuthService().logout();
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
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
                    Text("Getting your location..."),
                  ],
                ),
              )
              : GoogleMap(
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                style: _mapStyle,
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
                    markerId: const MarkerId("initial"),
                    icon: currentLocationIcon,
                    position: LatLng(
                      currentLocation!.latitude!,
                      currentLocation!.longitude!,
                    ),
                  ),
                },
              ),
        ],
      ),
    );
  }
}
