import 'package:path_provider/path_provider.dart';

abstract class IPathProvider {
  Future<String> get aplicationStorageDirectory;
  Future<String> get cacheStorageDirectory;
  Future<String> get externalStorageDirectory;
  Future<String> get temporaryStorageDirectory;
}

class PathProviderAdapter implements IPathProvider {
  @override
  Future<String> get aplicationStorageDirectory async =>
      getApplicationDocumentsDirectory().then(
        (dir) => dir.path,
      );

  @override
  Future<String> get cacheStorageDirectory async =>
      getExternalCacheDirectories().then(
        (dir) => dir != null && dir.isNotEmpty ? dir[0].path : "",
      );

  @override
  Future<String> get externalStorageDirectory async =>
      getExternalStorageDirectory().then(
        (dir) => dir != null ? dir.path : "",
      );

  @override
  Future<String> get temporaryStorageDirectory async =>
      getTemporaryDirectory().then(
        (dir) => dir.path,
      );
}
