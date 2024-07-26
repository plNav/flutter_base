class ManagerClient {
  static final ManagerClient _managerInstance = ManagerClient._internal();

  ManagerClient._internal();

  String? user;
  String? establishment;
  String? config;

  factory ManagerClient() => _managerInstance;

  void setUser(String user) {
    this.user = user;
  }
}
