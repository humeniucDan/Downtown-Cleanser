import 'package:bitstone_contest/models/detection_model.dart';

class PhotoModel {
  final int id;
  final DateTime postedAt;
  final int postedBy;
  final bool isProcessed;
  final DateTime? processedAt;
  final String rawImageUrl;
  final String? annotatedImageUrl;
  final double lat;
  final double lng;
  final String fileName;
  final List<DetectionModel> detections;

  PhotoModel({
    required this.id,
    required this.postedAt,
    required this.postedBy,
    required this.isProcessed,
    this.processedAt,
    required this.rawImageUrl,
    this.annotatedImageUrl,
    required this.lat,
    required this.lng,
    required this.fileName,
    required this.detections,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'],
      postedAt: DateTime.parse(json['postedAt']),
      postedBy: json['postedBy'],
      isProcessed: json['processed'],
      processedAt:
          json['processedAt'] != null
              ? DateTime.parse(json['processedAt'])
              : null,

      rawImageUrl: json['rawImageUrl'],
      annotatedImageUrl: json['annotatedImageUrl'],
      lat: json['lat'].toDouble(),
      lng: json['lng'].toDouble(),
      fileName: json['fileName'],
      detections:
          (json['detections'] as List<dynamic>)
              .map((e) => DetectionModel.fromJson(e))
              .toList(),
    );
  }
}
