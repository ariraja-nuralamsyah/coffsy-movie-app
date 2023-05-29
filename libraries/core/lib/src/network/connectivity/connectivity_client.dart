import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';

import 'i_connectivity_client.dart';

class ConnectivityClient extends IConnectivityClient {
  Logger logger = Logger();
  final MethodChannel _channel = const MethodChannel('network_channel');

  Future<void> switchData() async {
    try {
      await _channel.invokeMethod('switchToMobileData');
      // ignore: empty_catches
      logger.d('Data berubah');
      await isWifiConnected();
    } on PlatformException {}
  }

  @override
  Future<bool> checkDataConnection() async {
    logger.d(await InternetConnectionChecker().hasConnection ? 'Koneksi terhubung' : 'Koneksi tidak ada');

    return InternetConnectionChecker().hasConnection;
  }

  @override
  Future<bool> isWifiConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    logger.d(connectivityResult);

    return connectivityResult == ConnectivityResult.wifi;
  }

  @override
  Future<void> switchToMobileData() async {
    await switchData();
  }
}
