class PersistedData {
  final String username;
  final String token;
  final String locale;
  final bool isLightMode;

  PersistedData({
    required this.username,
    required this.token,
    required this.locale,
    required this.isLightMode,
  });

  PersistedData copyWith({
    String? username,
    String? token,
    String? locale,
    bool? isLightMode,
  }) {
    return PersistedData(
      username: username ?? this.username,
      token: token ?? this.token,
      locale: locale ?? this.locale,
      isLightMode: isLightMode ?? this.isLightMode,
    );
  }
}
