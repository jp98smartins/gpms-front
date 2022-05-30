import 'package:gpms/app/core/adapters/path_provider_adapter.dart';
import 'package:hive/hive.dart';

abstract class ILocalStorage {
  /// Method that reads, by key, a single register inside a box.
  dynamic read(String key) {}

  /// Method that writes, by key, a single register inside a box.
  Future<void> write(String key, dynamic value) async {}

  /// Method that deletes, by key, a single register inside a box.
  Future<void> delete(String key) async {}

  /// Method that deletes every single register inside a box.
  Future<void> clear() async {}
}

class LocalStorageAdapter implements ILocalStorage {
  LocalStorageAdapter({required this.boxName}) {
    initialize(boxName);
  }

  late final Box _box;
  final String boxName;
  final IPathProvider _pathProvider = PathProviderAdapter();

  void initialize(String boxName) async {
    Hive.init(await _pathProvider.aplicationStorageDirectory);
    _box = await Hive.openBox(boxName);
  }

  @override
  Future<void> clear() {
    try {
      return _box.clear();
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> delete(String key) async {
    try {
      return await _box.delete(key);
    } catch (error) {
      rethrow;
    }
  }

  @override
  dynamic read(String key) {
    try {
      return _box.get(key);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> write(String key, value) async {
    try {
      return await _box.put(key, value);
    } catch (error) {
      rethrow;
    }
  }
}
