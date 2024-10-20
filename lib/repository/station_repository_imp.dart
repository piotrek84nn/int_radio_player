import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:piotrek84nn_int_radio_player/models/media_source.dart';
import 'package:piotrek84nn_int_radio_player/presentation/constants/constant.dart';
import 'package:piotrek84nn_int_radio_player/repository/i_station_repository.dart';
import 'package:piotrek84nn_int_radio_player/utils/storage/i_storage.dart';

class StationRepositoryImp implements IStationRepository {
  StationRepositoryImp({
    required this.storage,
  });

  final IStorage storage;
  final _mediaSourceList = <MediaSources>[];

  @override
  List<MediaSources> get media => _mediaSourceList;

  @override
  Future<void> getRadioStations() async {
    _mediaSourceList.addAll(await _loadStationList());
    final lastPlayedStation = await _getLastPlayedStationUrl();

    if (lastPlayedStation != null) {
      final newDefault =
          media.firstWhere((element) => element.url == lastPlayedStation);
      media
        ..remove(newDefault)
        ..insert(0, newDefault);
    }
  }

  @override
  Future<void> setLastPlayedStation(int idx) async {
    await storage.write(
      key: lastPlayedStationUrl,
      value: media[idx].url,
    );
  }

  Future<String?> _getLastPlayedStationUrl() async {
    final containsLastPlaedStationIdx =
        await storage.containsKey(key: lastPlayedStationUrl);
    if (containsLastPlaedStationIdx) {
      return storage.read(key: lastPlayedStationUrl);
    }

    return null;
  }

  Future<List<MediaSources>> _loadStationList() async {
    final response = await rootBundle.loadString('assets/json/station_db.json');
    final data = (jsonDecode(response) as List).cast<Map<String, dynamic>>();
    return data.map<MediaSources>(MediaSources.fromJson).toList();
  }
}
