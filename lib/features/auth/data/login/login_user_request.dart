/// Entity
class LoginUserRequest {
  const LoginUserRequest({
    required this.password,
    required this.username,
    required this.authtype,
  });

  final String username;

  final String password;
  final  String authtype;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "password": password,
        "username": username,
        "user_type": authtype,
      };
}
