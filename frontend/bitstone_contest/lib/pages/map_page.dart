import 'dart:async';
import 'package:bitstone_contest/common/widgets/custom_report_button.dart';
import 'package:bitstone_contest/models/photo_model.dart';
import 'package:bitstone_contest/pages/view_a_report_page.dart';
import 'package:bitstone_contest/services/auth_service.dart';
import 'package:bitstone_contest/services/user_service.dart';
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
  Set<Marker> _markers = {};
  List<PhotoModel> _userPhotos = [];

  Future<void> _loadUserPhotos() async {
    //mock json for testing purpose
    final mockJson = {
      "id": 1,
      "postedAt": "2025-05-10T22:37:45.483+00:00",
      "postedBy": 1,
      "processedAt": "2025-05-10T22:37:56.524+00:00",
      "rawImageUrl":
          "https://compatible-amaranth-antelope.myfilebase.com/ipfs/QmT7UMmE3tqLuWBuikh4wFqL21174FCpmN34z1xyyyD7YT",
      "annotatedImageUrl":
          "https://compatible-amaranth-antelope.myfilebase.com/ipfs/QmZwy7JZ5cMSQ4w6x1XpCke7yegrvJ1eYKemayuACwPmBC",
      "lat": 10.0,
      "lng": 20.0,
      "fileName":
          "e08a8c1e42cbb2954a93a9e9ce799ca17350152d3bc2e688287cfd694d4c173a.png",
      "detections": [
        {
          "id": 1,
          "photoId": 1,
          "x1": 449,
          "y1": 690,
          "x2": 740,
          "y2": 1062,
          "classId": 9,
          "className": "damaged_street_lights",
          "isResolved": null,
          "resolvedAt": null,
        },
      ],
      "processed": true,
    };

    final user = await UserService().getCurrentUser();
    if (user != null && user.images.isNotEmpty) {
      setState(() {
        _userPhotos = user.images;
        _userPhotos.add(PhotoModel.fromJson(mockJson));
        _markers =
            _userPhotos
                .where((photo) => photo.lat != null && photo.lng != null)
                .map(
                  (photo) => Marker(
                    markerId: MarkerId(photo.id.toString()),
                    position: LatLng(photo.lat!, photo.lng!),
                    infoWindow: InfoWindow(
                      title: "View Photo",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewReport(photo: photo),
                          ),
                        );
                      },
                    ),
                  ),
                )
                .toSet();
      });
    }
  }

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
                              userEmail ?? "Loading...",
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
                    Text("Loading Map..."),
                  ],
                ),
              )
              : GoogleMap(
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                cloudMapId: "3862fa5c70e57954",
                onMapCreated: (mapController) async {
                  _controller.complete(mapController);
                  await _loadUserPhotos();
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    currentLocation!.latitude!,
                    currentLocation!.longitude!,
                  ),
                  zoom: 16.0,
                ),
                markers: _markers,
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
