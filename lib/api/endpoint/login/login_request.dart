class LoginRequest {
  final String username;
  final String password;


  LoginRequest({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => <String, dynamic> {
    'username': this.username,
    'password': this.password,
  };
}