import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class Network {
  Future<bool> get isConnected;
}

class NetworkImpl implements Network {
  @override
  Future<bool> get isConnected async =>
      await InternetConnectionChecker().hasConnection;
}
