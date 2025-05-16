class AuthorityModel {
  final int? id;
  final String name;
  final String email;
  final String? hqAddress;
  final String? repCode;
  final String? password;
  final List<int> accessibleProblemClassIds;

  AuthorityModel({
    this.id,
    required this.name,
    required this.email,
    this.hqAddress,
    this.repCode,
    this.password,
    required this.accessibleProblemClassIds,
  });

  factory AuthorityModel.fromJson(Map<String, dynamic> json) {
    return AuthorityModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      hqAddress: json['hqAddress'],
      password: null,
      accessibleProblemClassIds: List<int>.from(
        json['accessibleProblemClassIds'] ?? [],
      ),
    );
  }

  Map<String, dynamic> toJson({bool includePassword = false}) {
    final map = {
      'name': name,
      'email': email,
      'hqAddress': hqAddress,
      'accessibleProblemClassIds': accessibleProblemClassIds,
    };

    if (includePassword && password != null) {
      map['password'] = password;
    }

    return map;
  }
}
