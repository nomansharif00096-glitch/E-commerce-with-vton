class Loginparam {
  final String email;
  final String password;
  Loginparam({required this.email, required this.password});
  factory Loginparam.fromJson(Map<String, dynamic> json) {
    return Loginparam(email: json['email'], password: json['password']);
  }
  Map<String, dynamic> toJson() => {"email": email, "password": password};
}
