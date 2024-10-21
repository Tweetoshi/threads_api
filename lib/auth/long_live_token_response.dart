
class LongLivedTokenResponse {
  final String accessToken;
  final String tokenType;
  final int expiresIn;

  LongLivedTokenResponse({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  factory LongLivedTokenResponse.fromJson(Map<String, dynamic> json) {
    return LongLivedTokenResponse(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      expiresIn: json['expires_in'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
    };
  }
}
