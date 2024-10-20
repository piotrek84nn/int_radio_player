import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class IConnectionMonitor {
  Stream<InternetStatus> get onStatusChange;
  Future<InternetStatus> get internetStatus;
}
