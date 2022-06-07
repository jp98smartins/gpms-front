import 'dart:developer';

import '../../adapters/local_storage_adapter.dart';
import '../../data/dtos/menu_config_dto.dart';

abstract class IMenuConfigProvider {
  Future<MenuConfigDto?> fecht();
  Future<bool> save(MenuConfigDto menuConfigDto);
}

class MenuConfigProvider implements IMenuConfigProvider {
  MenuConfigProvider(this._storageAdapter);

  final ILocalStorage _storageAdapter;

  static const menuConfigKey = 'menu_config';

  @override
  Future<MenuConfigDto?> fecht() async {
    try {
      return MenuConfigDto.fromJson(await _storageAdapter.read(menuConfigKey));
    } catch (e) {
      log('[MenuConfigProvider.fecht()] -> $e');
      return null;
    }
  }

  @override
  Future<bool> save(MenuConfigDto menuConfigDto) async {
    try {
      await _storageAdapter.write(
        menuConfigKey,
        MenuConfigDto.toJson(menuConfigDto),
      );
      return true;
    } catch (e) {
      log('[MenuConfigProvider.save()] -> $e');
      return false;
    }
  }
}
