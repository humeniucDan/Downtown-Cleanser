class UserRegisterModel {
  final String fullName;
  final String email;
  final String password;
  final String? repCode;

  UserRegisterModel({
    required this.fullName,
    required this.email,
    required this.password,
    this.repCode,
  });

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'email': email,
    'password': password,
    'repCode': repCode,
  };
}
