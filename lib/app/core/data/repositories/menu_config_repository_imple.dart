import '../../domain/repositories/menu_config_repository.dart';
import '../dtos/menu_config_dto.dart';
import '../providers/menu_config_provider.dart';

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
