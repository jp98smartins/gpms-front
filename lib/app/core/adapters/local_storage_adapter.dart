

import 'package:hive/hive.dart';

abstract class ILocalStorage {
  // Method that creates the Local Storage Box.
  set box(String boxName);

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
  late Box _box;

  @override
  set box(String boxName) {
    _box = Hive.box(boxName);
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
      return _box.delete(key);
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
  Future<void> write(String key, value) {
    try {
      return _box.put(key, value);
    } catch (error) {
      rethrow;
    }
  }
}
