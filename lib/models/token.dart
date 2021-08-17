class Token {
  final String accessToken;
  final String? refreshToken;
  final dynamic extra;

  Token({required this.accessToken, this.refreshToken, this.extra});

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        accessToken: json['accessToken'] as String,
        refreshToken: json['refreshToken'] as String?,
        extra: json['extra'],
      );

  factory Token.fromData(
          String accessToken, String? refreshToken, dynamic extra) =>
      Token(
        accessToken: accessToken,
        refreshToken: refreshToken,
        extra: extra,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'extra': extra
      };

  @override
  String toString() {
    return 'Token{accessToken: $accessToken, refreshToken: $refreshToken, extra: $extra}';
  }
}
