import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:piotrek84nn_int_radio_player/utils/connection_monitor/i_connection_monitor.dart';

class ConnectionMonitor implements IConnectionMonitor {
  final _connectionEventStream = InternetConnection();

  @override
  Stream<InternetStatus> get onStatusChange =>
      _connectionEventStream.onStatusChange;

  @override
  Future<InternetStatus> get internetStatus =>
      _connectionEventStream.internetStatus;
}
