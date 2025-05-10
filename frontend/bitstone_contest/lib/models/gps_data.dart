class GpsData {
  final double latitude;
  final double longitude;

  GpsData({required this.latitude, required this.longitude});

  Map<String, dynamic> toJson() => {'lat': latitude, 'lng': longitude};
}
