abstract class IConnectivityClient {
  Future<bool> checkDataConnection();
  Future<void> switchToMobileData();
  Future<bool> isWifiConnected();
}
