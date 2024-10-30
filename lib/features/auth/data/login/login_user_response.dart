

class LoginUserResponse {

  LoginUserResponse({
    required this.tokenType,
    required this.accessToken,
    required this.refreshToken,
    required this.permissions,
  });

  factory LoginUserResponse.fromJson(Map<String, dynamic> json) => LoginUserResponse(
    tokenType: json["token_type"],
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"],
    permissions: List<String>.from(json["permissions"].map((x) => x)),
  );

  final String tokenType;
  final String accessToken;
  final String refreshToken;
  final List<String> permissions;


}
