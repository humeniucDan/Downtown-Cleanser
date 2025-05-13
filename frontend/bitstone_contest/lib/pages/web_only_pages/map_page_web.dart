import 'dart:async';
import 'package:bitstone_contest/common/widgets/custom_report_button.dart';
import 'package:bitstone_contest/models/photo_model.dart';
import 'package:bitstone_contest/pages/view_a_report_page.dart';
import 'package:bitstone_contest/services/auth_service.dart';
import 'package:bitstone_contest/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapPageWeb extends StatefulWidget {
  const MapPageWeb({super.key});

  @override
  State<MapPageWeb> createState() => _MapPageWebState();
}

class _MapPageWebState extends State<MapPageWeb> {
  String? userEmail;
  final Completer<GoogleMapController> _controller = Completer();
  Position? currentPosition;
  Set<Marker> _markers = {};
  List<PhotoModel> _userPhotos = [];
  String? _mapStyle;

  Future<void> _loadUserPhotos() async {
    final mockJsonArray = [
      {
        "id": 5,
        "postedAt": "2025-05-13T16:43:56.821+00:00",
        "postedBy": 1,
        "processedAt": "2025-05-13T16:44:02.264+00:00",
        "rawImageUrl":
            "https://compatible-amaranth-antelope.myfilebase.com/ipfs/QmUpRfVwL6G7scUqp32xZQ3P2NwwcZ4tzdQyaQmxYLUKfa",
        "annotatedImageUrl":
            "https://compatible-amaranth-antelope.myfilebase.com/ipfs/QmVPXmERoEfrcHdGqKdfy1oMrLT7QjtABznE1KXaWVBxPH",
        "lat": 10.0,
        "lng": 20.0,
        "fileName":
            "12cd61449ab1333e30f8e8f9e3f52f2be0beba13597e9a79df15bb5192beb0a2.png",
        "detections": [
          {
            "id": 3,
            "imageId": 5,
            "x1": 190,
            "y1": 168,
            "x2": 620,
            "y2": 634,
            "classId": 1,
            "className": "illegal_parking",
            "isResolved": false,
            "resolvedAt": null,
          },
        ],
        "processed": true,
      },
      {
        "id": 14,
        "postedAt": "2025-05-13T17:11:12.664+00:00",
        "postedBy": 1,
        "processedAt": "2025-05-13T17:11:17.196+00:00",
        "rawImageUrl":
            "https://compatible-amaranth-antelope.myfilebase.com/ipfs/QmTZR3nSS8bHbuRaXvHxVwSuj4rr8XX7vPir5bYZyXiDPY",
        "annotatedImageUrl":
            "https://compatible-amaranth-antelope.myfilebase.com/ipfs/QmSbwk5FeNgY6wvk2U5psnhtq3sBWoy43x5Yd9vBB4mkyc",
        "lat": 46.7568472,
        "lng": 23.5957982,
        "fileName":
            "45ea24a0aa6b31b37ce310b017ea8c8543222aa07c67620df9f339b3983d4cc5.png",
        "detections": [
          {
            "id": 8,
            "imageId": 14,
            "x1": 19,
            "y1": 0,
            "x2": 339,
            "y2": 633,
            "classId": 1,
            "className": "illegal_parking",
            "isResolved": false,
            "resolvedAt": null,
          },
        ],
        "processed": true,
      },
      {
        "id": 15,
        "postedAt": "2025-05-13T17:12:07.313+00:00",
        "postedBy": 1,
        "processedAt": "2025-05-13T17:12:11.685+00:00",
        "rawImageUrl":
            "https://compatible-amaranth-antelope.myfilebase.com/ipfs/QmfXaRug4gJzYqbY6BoChVSNSFf68QcQgxxt5R37ptsW9q",
        "annotatedImageUrl":
            "https://compatible-amaranth-antelope.myfilebase.com/ipfs/QmW64px3aP9ju7X4UvxayAPna2NEHVHHRmAKxkqscZDDKs",
        "lat": 46.7564812,
        "lng": 23.5958143,
        "fileName":
            "1e5c361562243972785711103a75bd3197f9d74a69368959522a7f7602e92a0d.png",
        "detections": [
          {
            "id": 9,
            "imageId": 15,
            "x1": 128,
            "y1": 179,
            "x2": 352,
            "y2": 505,
            "classId": 1,
            "className": "illegal_parking",
            "isResolved": false,
            "resolvedAt": null,
          },
        ],
        "processed": true,
      },
      {
        "id": 16,
        "postedAt": "2025-05-13T17:13:23.250+00:00",
        "postedBy": 1,
        "processedAt": "2025-05-13T17:13:29.499+00:00",
        "rawImageUrl":
            "https://compatible-amaranth-antelope.myfilebase.com/ipfs/QmRKaeNW4SXntvffNRXcKefknK6jHUdp31SkutNLhuvfry",
        "annotatedImageUrl":
            "https://compatible-amaranth-antelope.myfilebase.com/ipfs/QmSB1Hiu5L32UHHQ8qiCh9dBRRCuh878HjQ9su1eTzUzPZ",
        "lat": 46.7561365,
        "lng": 23.5953785,
        "fileName":
            "5f1031a5950a49712965d2481a19f86df274f5b0881f783beda95b4afbeab847.png",
        "detections": [
          {
            "id": 10,
            "imageId": 16,
            "x1": 369,
            "y1": 378,
            "x2": 640,
            "y2": 640,
            "classId": 1,
            "className": "illegal_parking",
            "isResolved": false,
            "resolvedAt": null,
          },
        ],
        "processed": true,
      },
      {
        "id": 19,
        "postedAt": "2025-05-13T17:21:38.581+00:00",
        "postedBy": 1,
        "processedAt": "2025-05-13T17:21:46.624+00:00",
        "rawImageUrl":
            "https://compatible-amaranth-antelope.myfilebase.com/ipfs/QmNSR4d4K63hdME7q6rcmjiSsuAaRemhimvJrFBNSBCu8h",
        "annotatedImageUrl":
            "https://compatible-amaranth-antelope.myfilebase.com/ipfs/QmbbjC6pxDqeYEiDCfBLymhVj4nSZmYzi2iXsAERRQ4ZMC",
        "lat": 46.7561913,
        "lng": 23.5885174,
        "fileName":
            "e2f3c89d838c4a6372bd38f965e745ebb5d99a0f4818620a1c6ff2ccb98fe485.png",
        "detections": [
          {
            "id": 17,
            "imageId": 19,
            "x1": 364,
            "y1": 0,
            "x2": 640,
            "y2": 134,
            "classId": 1,
            "className": "Illegally parked vehicles",
            "isResolved": false,
            "resolvedAt": null,
          },
        ],
        "processed": true,
      },
      {
        "id": 20,
        "postedAt": "2025-05-13T17:23:02.968+00:00",
        "postedBy": 1,
        "processedAt": "2025-05-13T17:23:07.730+00:00",
        "rawImageUrl":
            "https://compatible-amaranth-antelope.myfilebase.com/ipfs/QmaiqrMcLqdQAmDnE7Ns8aDHSsv6FPzfFoLoDYGdn32Yyw",
        "annotatedImageUrl":
            "https://compatible-amaranth-antelope.myfilebase.com/ipfs/QmPJ2NeKVyxUSEwuRgtyksY28x2XbqsMWVEHJ5FsPbKPHv",
        "lat": 46.7565322,
        "lng": 23.5883564,
        "fileName":
            "286f6fd7738ce9b75499866de7e8fbbdbe1fe94ea7c5e076c98017a31ff559fc.png",
        "detections": [
          {
            "id": 18,
            "imageId": 20,
            "x1": 209,
            "y1": 212,
            "x2": 379,
            "y2": 445,
            "classId": 1,
            "className": "illegally_parked_vehicles",
            "isResolved": false,
            "resolvedAt": null,
          },
        ],
        "processed": true,
      },
      {
        "id": 22,
        "postedAt": "2025-05-13T17:25:33.597+00:00",
        "postedBy": 1,
        "processedAt": "2025-05-13T17:25:38.969+00:00",
        "rawImageUrl":
            "https://compatible-amaranth-antelope.myfilebase.com/ipfs/QmbKVrjEZ2VxWLbscsMYdYJ526qhKALF1M5aZ6zcGTKkVU",
        "annotatedImageUrl":
            "https://compatible-amaranth-antelope.myfilebase.com/ipfs/QmSS4xR1vMAx1SoS4Ly5wJLtzsdZ8n5hLGj9AhdGSSUYAU",
        "lat": 46.7573665,
        "lng": 23.5881457,
        "fileName":
            "1ca396936198aae502c8cb7dd98ab25a1b85a89430bb061df4705917b12fc449.png",
        "detections": [
          {
            "id": 20,
            "imageId": 22,
            "x1": 326,
            "y1": 441,
            "x2": 480,
            "y2": 633,
            "classId": 1,
            "className": "illegally_parked_vehicles",
            "isResolved": false,
            "resolvedAt": null,
          },
        ],
        "processed": true,
      },
      {
        "id": 24,
        "postedAt": "2025-05-13T17:39:36.435+00:00",
        "postedBy": 1,
        "processedAt": "2025-05-13T17:39:42.384+00:00",
        "rawImageUrl":
            "https://compatible-amaranth-antelope.myfilebase.com/ipfs/QmcwnxD2QbTDG1NmX3QcTs5MtK3KpyUj15tpJiV65xToXm",
        "annotatedImageUrl":
            "https://compatible-amaranth-antelope.myfilebase.com/ipfs/QmPcqN56XL6QZ5ZBEyuTKnzn5C7ncDadEBfghcRigZihLb",
        "lat": 46.7568677,
        "lng": 23.5852744,
        "fileName":
            "51d67e52a50f6a389518234f65a012c01eddd4e6f12d0bfd29084901b1486cd1.png",
        "detections": [
          {
            "id": 23,
            "imageId": 24,
            "x1": 300,
            "y1": 256,
            "x2": 640,
            "y2": 620,
            "classId": 1,
            "className": "illegal_parking",
            "isResolved": false,
            "resolvedAt": null,
          },
        ],
        "processed": true,
      },
      {
        "id": 25,
        "postedAt": "2025-05-13T17:40:18.842+00:00",
        "postedBy": 1,
        "processedAt": "2025-05-13T17:40:25.290+00:00",
        "rawImageUrl":
            "https://compatible-amaranth-antelope.myfilebase.com/ipfs/QmUmSZWaKjc6DdqLyn6KhTj6mo8aarrDX3TTagdSujntSe",
        "annotatedImageUrl":
            "https://compatible-amaranth-antelope.myfilebase.com/ipfs/QmSpVyLzMMcH3oEHgYYdFHz6iAJExEvVkN7mJAAbwXRVBG",
        "lat": 46.7568695,
        "lng": 23.5852647,
        "fileName":
            "3a42619e732b3ffb2728da060659bf41985a5cb3a4317848340e53040f710136.png",
        "detections": [
          {
            "id": 24,
            "imageId": 25,
            "x1": 25,
            "y1": 204,
            "x2": 428,
            "y2": 633,
            "classId": 1,
            "className": "illegal_parking",
            "isResolved": false,
            "resolvedAt": null,
          },
          {
            "id": 25,
            "imageId": 25,
            "x1": 345,
            "y1": 294,
            "x2": 480,
            "y2": 428,
            "classId": 1,
            "className": "illegal_parking",
            "isResolved": false,
            "resolvedAt": null,
          },
          {
            "id": 26,
            "imageId": 25,
            "x1": 480,
            "y1": 288,
            "x2": 633,
            "y2": 403,
            "classId": 1,
            "className": "illegal_parking",
            "isResolved": false,
            "resolvedAt": null,
          },
        ],
        "processed": true,
      },
      {
        "id": 26,
        "postedAt": "2025-05-13T17:40:57.080+00:00",
        "postedBy": 1,
        "processedAt": "2025-05-13T17:41:02.357+00:00",
        "rawImageUrl":
            "https://compatible-amaranth-antelope.myfilebase.com/ipfs/QmWeAvbjdeEdQKtPhZ26VVaeGPG33eoDpqMKX5YpVcCHyX",
        "annotatedImageUrl":
            "https://compatible-amaranth-antelope.myfilebase.com/ipfs/QmeMt77uHMog1i8jRDpV3FWiET8LZ9sS18QnhLt76tJenW",
        "lat": 46.7568699,
        "lng": 23.5852628,
        "fileName":
            "e7293d619e9519b4133f93ad8dc617c380321927ab7084f8d001821ef5da1a58.png",
        "detections": [
          {
            "id": 27,
            "imageId": 26,
            "x1": 224,
            "y1": 243,
            "x2": 608,
            "y2": 627,
            "classId": 1,
            "className": "illegal_parking",
            "isResolved": false,
            "resolvedAt": null,
          },
          {
            "id": 28,
            "imageId": 26,
            "x1": 96,
            "y1": 96,
            "x2": 268,
            "y2": 179,
            "classId": 1,
            "className": "illegal_parking",
            "isResolved": false,
            "resolvedAt": null,
          },
        ],
        "processed": true,
      },
    ];

    final mockJson = {
      "id": 1,
      "postedAt": "2025-05-10T22:37:45.483+00:00",
      "postedBy": 1,
      "processedAt": "2025-05-10T22:37:56.524+00:00",
      "rawImageUrl":
          "https://compatible-amaranth-antelope.myfilebase.com/ipfs/QmT7UMmE3tqLuWBuikh4wFqL21174FCpmN34z1xyyyD7YT",
      "annotatedImageUrl":
          "https://compatible-amaranth-antelope.myfilebase.com/ipfs/QmYQQMdTKe6U7x96GvFQn7DDuHKrwLVDgz6q1c2AKqb1os",
      "lat": 10.0,
      "lng": 20.0,
      "fileName":
          "e08a8c1e42cbb2954a93a9e9ce799ca17350152d3bc2e688287cfd694d4c173a.png",
      "detections": [
        {
          "id": 1,
          "imageId": 1,
          "x1": 449,
          "y1": 690,
          "x2": 740,
          "y2": 1062,
          "classId": 9,
          "className": "damaged_street_lights",
          "isResolved": false,
          "resolvedAt": null,
        },
      ],
      "processed": true,
    };

    //final user = await UserService().getCurrentUserWeb();
    //if (user != null && user.images.isNotEmpty) {
    final List<PhotoModel> photoList =
        mockJsonArray
            .map((photoJson) => PhotoModel.fromJson(photoJson))
            .toList();

    setState(() {
      //    _userPhotos = photoList;
      _userPhotos.add(PhotoModel.fromJson(mockJson));
      try {
        _markers =
            photoList.map((photo) {
              return Marker(
                markerId: MarkerId(photo.id.toString()),
                position: LatLng(photo.lat.toDouble(), photo.lng.toDouble()),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ViewReport(photo: photo)),
                  );
                },
              );
            }).toSet();
      } catch (e, stack) {
        print('Marker creation error: $e');
        print(stack);
      }
    });
    //}
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      currentPosition = position;
    });
  }

  Future<String?> getUserNameFromToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null) return null;

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    setState(() {
      userEmail = decodedToken['email'];
    });
    return userEmail;
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
    rootBundle.loadString('assets/map_style.json').then((string) {
      _mapStyle = string;
    });
    getCurrentLocation();
    _loadUserPhotos();
    getUserNameFromToken();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 254, 55, 108),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 32),
            child: Image.asset("assets/logo-500x500.png", height: 200),
          ),
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
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 245, 78, 123),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    children: [
                      const CircleAvatar(child: Icon(Icons.person)),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userEmail ?? "Loading...",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "Hero of the city",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
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
              onTap: () => Navigator.pushNamed(context, '/report_history'),
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
          currentPosition == null
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
                style: _mapStyle,
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                onMapCreated: (mapController) async {
                  _controller.complete(mapController);

                  await _cameraToPosition(
                    LatLng(
                      currentPosition!.latitude,
                      currentPosition!.longitude,
                    ),
                  );
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    currentPosition!.latitude,
                    currentPosition!.longitude,
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
