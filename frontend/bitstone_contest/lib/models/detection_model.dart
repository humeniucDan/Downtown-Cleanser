class DetectionModel {
  final int id;
  final int photoId;
  final int? x1;
  final int? y1;
  final int? x2;
  final int? y2;
  final int classId;
  final String className;
  final bool? isResolved;
  final DateTime? resolvedAt;

  DetectionModel({
    required this.id,
    required this.photoId,
    this.x1,
    this.y1,
    this.x2,
    this.y2,
    this.isResolved,
    this.resolvedAt,
    required this.classId,
    required this.className,
  });

  factory DetectionModel.fromJson(Map<String, dynamic> json) {
    return DetectionModel(
      id: json['id'],
      photoId: json['imageId'],
      x1: json['x1'],
      y1: json['y1'],
      x2: json['x2'],
      y2: json['y2'],
      classId: json['classId'],
      className: json['className'],
      isResolved: json['isResolved'],
      resolvedAt: json['resolvedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageId': photoId,
      'x1': x1,
      'y1': y1,
      'x2': x2,
      'y2': y2,
      'classId': classId,
      'className': className,
      'isResolved': isResolved,
      'resolvedAt': resolvedAt,
    };
  }
}
