import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:piotrek84nn_int_radio_player/utils/storage/i_storage.dart';

class StorageImp implements IStorage {
  StorageImp();
  final _storage = const FlutterSecureStorage();

  @override
  Future<bool> containsKey({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
  }) {
    return _storage.containsKey(
      key: key,
      iOptions: iOptions,
      aOptions: aOptions,
    );
  }

  @override
  Future<String?> read({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
  }) {
    return _storage.read(
      key: key,
      iOptions: iOptions,
      aOptions: aOptions,
    );
  }

  @override
  Future<void> write({
    required String key,
    required String? value,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
  }) async {
    await _storage.write(
      key: key,
      value: value,
      iOptions: iOptions,
      aOptions: aOptions,
    );
  }
}
