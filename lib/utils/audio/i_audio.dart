import 'package:just_audio/just_audio.dart';

abstract class IAudio {
  Stream<IcyMetadata?> get icyMetadataStream;

  Future<Duration?> setAudioSource(
    AudioSource source, {
    bool preload = true,
    int? initialIndex,
    Duration? initialPosition,
  });

  Future<void> play();
  Future<void> stop();
  Future<void> dispose();
}
