import 'package:get_it/get_it.dart';
import 'package:piotrek84nn_int_radio_player/bloc/player_bloc.dart';
import 'package:piotrek84nn_int_radio_player/presentation/ui_helpers/i_toast.dart';
import 'package:piotrek84nn_int_radio_player/presentation/ui_helpers/toast_imp.dart';
import 'package:piotrek84nn_int_radio_player/repository/i_station_repository.dart';
import 'package:piotrek84nn_int_radio_player/repository/station_repository_imp.dart';
import 'package:piotrek84nn_int_radio_player/utils/audio/audio_imp.dart';
import 'package:piotrek84nn_int_radio_player/utils/audio/i_audio.dart';
import 'package:piotrek84nn_int_radio_player/utils/connection_monitor/connection_monitor_imp.dart';
import 'package:piotrek84nn_int_radio_player/utils/connection_monitor/i_connection_monitor.dart';
import 'package:piotrek84nn_int_radio_player/utils/di/i_locator.dart';
import 'package:piotrek84nn_int_radio_player/utils/storage/i_storage.dart';
import 'package:piotrek84nn_int_radio_player/utils/storage/storage_imp.dart';

class LocatorImp extends ILocator {
  LocatorImp.newInstance() : _di = GetIt.asNewInstance();
  final GetIt _di;

  @override
  LocatorImp initialize() {
    _di
      ..registerLazySingleton<IAudio>(AudioImp.new)
      ..registerSingleton<IStorage>(StorageImp())
      ..registerSingleton<IConnectionMonitor>(ConnectionMonitor())
      ..registerSingleton<IStationRepository>(
        StationRepositoryImp(
          storage: _di.get(),
        ),
      )
      ..registerSingleton<IToast>(ToastImp())
      ..registerFactory(
        () => PlayerBloc(
          stationRepository: _di.get(),
          toast: _di.get(),
          audioPlayer: _di.get(),
          connectionMonitor: _di.get(),
        ),
      );

    return this;
  }

  @override
  T get<T extends Object>({
    dynamic param1,
    dynamic param2,
    String? instanceName,
    Type? type,
  }) {
    return _di.get(
      param1: param1,
      param2: param2,
      instanceName: instanceName,
      type: type,
    );
  }
}
