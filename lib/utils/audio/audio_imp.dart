import 'package:just_audio/just_audio.dart';
import 'package:piotrek84nn_int_radio_player/utils/audio/i_audio.dart';

class AudioImp implements IAudio {
  AudioImp();
  final _audioPlayer = AudioPlayer();

  @override
  Stream<IcyMetadata?> get icyMetadataStream => _audioPlayer.icyMetadataStream;

  @override
  Future<void> play() async {
    await _audioPlayer.play();
  }

  @override
  Future<Duration?> setAudioSource(
    AudioSource source, {
    bool preload = true,
    int? initialIndex,
    Duration? initialPosition,
  }) async {
    return _audioPlayer.setAudioSource(
      source,
      preload: preload,
      initialIndex: initialIndex,
      initialPosition: initialPosition,
    );
  }

  @override
  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  @override
  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}
