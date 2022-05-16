import '../../data/dtos/menu_config_dto.dart';

abstract class IMenuConfigRepository{
  Future<MenuConfigDto?> fecht();
  Future<bool> save(MenuConfigDto menuConfigDto);
}
