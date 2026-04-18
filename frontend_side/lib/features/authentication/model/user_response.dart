class User {
  final int id;
  final String email;
  final String name;
  final String address;
  final String createdAt;
  final String updatedAt;
  User(
      {required this.id,
      required this.email,
      required this.name,
      required this.address,
      required this.createdAt,
      required this.updatedAt});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        email: json['email'],
        name: json['name'],
        address: json['address'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "address": address,
        "createdAt": createdAt,
        "updatedAt": updatedAt
      };
}

class UserResponse {
  final User user;
  final String accessToken;
  UserResponse({required this.user, required this.accessToken});
  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
        user: User.fromJson(json['user']), accessToken: json['accessToken']); 
  }
  Map<String, dynamic> toJson() =>
      {"user": user.toJson(), "accessToken": accessToken};
}
