import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// A service layer for checking internet connectivity.
class InternetConnectionService {
  InternetConnectionService._();
  static final InternetConnectionService _instance =
      InternetConnectionService._();

  /// Provides access to the singleton instance of [InternetConnectionService].
  static InternetConnectionService get instance => _instance;

  final InternetConnection _internetConnection = InternetConnection();

  /// Returns true if the device has an active internet connection.
  Future<bool> checkConnection() async {
    return _internetConnection.hasInternetAccess;
  }

  /// Stream to listen to internet connection status changes.
  Stream<InternetStatus> get connectionStream =>
      _internetConnection.onStatusChange;
}
