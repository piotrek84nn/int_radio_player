import 'dart:async';

import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:piotrek84nn_int_radio_player/bloc/player_event.dart';
import 'package:piotrek84nn_int_radio_player/bloc/player_state.dart';
import 'package:piotrek84nn_int_radio_player/presentation/constants/constant.dart';
import 'package:piotrek84nn_int_radio_player/presentation/ui_helpers/i_toast.dart';
import 'package:piotrek84nn_int_radio_player/repository/i_station_repository.dart';
import 'package:piotrek84nn_int_radio_player/utils/audio/i_audio.dart';
import 'package:piotrek84nn_int_radio_player/utils/connection_monitor/i_connection_monitor.dart';

class PlayerBloc extends Bloc<PlayerEvents, PlayerStates> {
  PlayerBloc({
    required this.stationRepository,
    required this.toast,
    required this.audioPlayer,
    required this.connectionMonitor,
  }) : super(const InitialState(0)) {
    on<PlayEvent>(_onPlayEvent);
    on<LostConnectionEvent>(_onLostConnectionEvent);
    on<IcyDataReceivedEvent>(_onIcyDataEvent);
  }

  final IStationRepository stationRepository;
  final IToast toast;
  final IAudio audioPlayer;
  final IConnectionMonitor connectionMonitor;

  late StreamSubscription<IcyMetadata?> _icyMetadataStream;
  late StreamSubscription<InternetStatus>? _connectionEventStream;
  String? _icyData;

  Future<void> onInitState() async {
    await _initInternetConnectionMonitor();
    await stationRepository.getRadioStations();
    FlutterNativeSplash.remove();
    _createIcyMetadataStream();

    add(const PlayEvent(selectedIndex: 0));
  }

  void _createIcyMetadataStream() {
    _icyMetadataStream = audioPlayer.icyMetadataStream.listen((event) {
      if (event?.info?.title == null || event?.info?.title == _icyData) {
        add(const IcyDataReceivedEvent());
        return;
      }

      _icyData = event?.info?.title;
      add(IcyDataReceivedEvent(icyData: _icyData));
    });
  }

  Future<void> _initInternetConnectionMonitor() async {
    connectionMonitor.onStatusChange.listen((InternetStatus status) async {
      switch (status) {
        case InternetStatus.connected:
          add(PlayEvent(selectedIndex: state.selectedIndex));
        case InternetStatus.disconnected:
          add(const LostConnectionEvent());
      }
    });
  }

  Future<void> _onPlayEvent(
    PlayEvent event,
    Emitter<PlayerStates> emit,
  ) async {
    await audioPlayer.stop();
    emit(
      PlayState(
        event.selectedIndex,
      ),
    );
    try {
      final item = stationRepository.media[event.selectedIndex];
      await audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(
            item.url!,
          ),
          tag: MediaItem(
            id: item.url!,
            title: item.title!,
          ),
        ),
      );
      await audioPlayer.play();
    } on PlayerException catch (e) {
      Fimber.d(e.toString());
    }
    await stationRepository.setLastPlayedStation(event.selectedIndex);
    emit(
      PlayState(
        event.selectedIndex,
      ),
    );
    toast.showToast(
      '$plaingTxt: ${stationRepository.media[event.selectedIndex].title!}',
    );
  }

  Future<void> _onIcyDataEvent(
    IcyDataReceivedEvent event,
    Emitter<PlayerStates> emit,
  ) async {
    emit(
      PlayState(
        state.selectedIndex,
        songTitle: event.icyData,
      ),
    );
  }

  Future<void> _onLostConnectionEvent(
    LostConnectionEvent event,
    Emitter<PlayerStates> emit,
  ) async {
    await audioPlayer.stop();
    emit(
      ReconnectingState(
        state.selectedIndex,
      ),
    );
  }

  void onDispose() {
    _icyMetadataStream.cancel();
    _connectionEventStream?.cancel();
    audioPlayer.dispose();
    toast.dispose();
  }
}
