class PersistedConfigData {
  final String token;
  final String username;
  final String password;

  PersistedConfigData({
    required this.token,
    required this.username,
    required this.password,
  });

  PersistedConfigData copyWith({
    String? token,
    String? username,
    String? password,
  }) {
    return PersistedConfigData(
      token: token ?? this.token,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}
