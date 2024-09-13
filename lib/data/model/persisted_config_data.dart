class PersistedConfigData {
  final String username;
  final String token;

  PersistedConfigData({
    required this.username,
    required this.token,
  });

  PersistedConfigData copyWith({
    String? username,
    String? token,
  }) {
    return PersistedConfigData(
      username: username ?? this.username,
      token: token ?? this.token,
    );
  }
}
