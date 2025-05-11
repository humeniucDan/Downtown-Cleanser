class DetectionModel {
  final int id;
  final int photoId;
  final int? x1;
  final int? y1;
  final int? x2;
  final int? y2;
  final int classId;
<<<<<<< HEAD
  final String className;
=======
>>>>>>> bb0a26e76af0f13a6a28c67f5c542c2695f3b361

  DetectionModel({
    required this.id,
    required this.photoId,
    this.x1,
    this.y1,
    this.x2,
    this.y2,
    required this.classId,
<<<<<<< HEAD
    required this.className,
=======
>>>>>>> bb0a26e76af0f13a6a28c67f5c542c2695f3b361
  });

  factory DetectionModel.fromJson(Map<String, dynamic> json) {
    return DetectionModel(
      id: json['id'],
      photoId: json['photoId'],
      x1: json['x1'],
      y1: json['y1'],
      x2: json['x2'],
      y2: json['y2'],
      classId: json['classId'],
<<<<<<< HEAD
      className: json['className'],
=======
>>>>>>> bb0a26e76af0f13a6a28c67f5c542c2695f3b361
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photoId': photoId,
      'x1': x1,
      'y1': y1,
      'x2': x2,
      'y2': y2,
      'classId': classId,
<<<<<<< HEAD
      'className': className,
=======
>>>>>>> bb0a26e76af0f13a6a28c67f5c542c2695f3b361
    };
  }
}
