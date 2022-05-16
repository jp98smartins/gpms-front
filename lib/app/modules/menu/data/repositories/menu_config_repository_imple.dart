import 'package:gpms/app/modules/menu/data/providers/menu_config_provider.dart';
import 'package:gpms/app/modules/menu/domain/repositories/menu_config_repository.dart';

import '../../data/dtos/menu_config_dto.dart';

class MenuConfigRepository implements IMenuConfigRepository {
  final IMenuConfigProvider _provider;

  MenuConfigRepository(this._provider);

  @override
  Future<MenuConfigDto?> fecht() async {
    return await _provider.fecht();
  }

  @override
  Future<bool> save(MenuConfigDto menuConfigDto) async {
    return await _provider.save(menuConfigDto);
  }
}
