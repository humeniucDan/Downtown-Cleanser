import 'photo_model.dart';

class UserModel {
  final int id;
  final String email;
  final String? fullName;
  final bool isAdmin;
  final bool isRep;
  final List<PhotoModel> images;

  UserModel({
    required this.id,
    required this.email,
    this.fullName,
    required this.isAdmin,
    required this.isRep,
    required this.images,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
      isAdmin: json['isAdmin'] ?? false,
      isRep: json['isRep'] ?? false,
      images:
          json['images'] != null
              ? List<PhotoModel>.from(
                json['images'].map((img) => PhotoModel.fromJson(img)),
              )
              : [],
    );
  }
}
