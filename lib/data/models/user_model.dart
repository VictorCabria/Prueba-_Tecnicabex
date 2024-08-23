class UserModel {
  final int? id;
  final String email;
  final String password;
  final String token;

  UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      token: map['token'],
    );
  }
}
