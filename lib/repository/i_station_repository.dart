import 'package:piotrek84nn_int_radio_player/models/media_source.dart';

abstract class IStationRepository {
  List<MediaSources> get media;
  Future<void> getRadioStations();
  Future<void> setLastPlayedStation(int idx);
}
