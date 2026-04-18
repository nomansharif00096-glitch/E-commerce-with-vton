class SignupParams {
  final String name;
  final String email;
  final String password;
  final String address;
  SignupParams(
      {required this.name,
      required this.email,
      required this.password,
      required this.address});
  factory SignupParams.fromJson(Map<String, dynamic> json) {
    return SignupParams(
        name: json['name'],
        email: json['email'],
        password: json['password'],
        address: json['address']);
  }
  Map<String, dynamic> toJson() =>
      {"name": name, "email": email, "password": password, "address": address};
}
