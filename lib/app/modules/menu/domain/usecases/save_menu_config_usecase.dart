import '../../data/dtos/menu_config_dto.dart';

abstract class ISaveMenuConfigUseCase {
  Future<bool> call(MenuConfigDto menuConfigDto);
}

class SaveMenuConfigUseCase implements ISaveMenuConfigUseCase {
  @override
  Future<bool> call(MenuConfigDto menuConfigDto) async {
    throw UnimplementedError();
  }
}
