import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkInfo{
  Future<bool> get isConnected;
}

class NetworkInfoIml implements NetworkInfo{
  final InternetConnection _connection;

  NetworkInfoIml(this._connection);

  @override
  Future<bool> get isConnected => _connection.hasInternetAccess;

}