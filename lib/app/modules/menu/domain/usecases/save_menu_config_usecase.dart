import '../../../../core/data/dtos/menu_config_dto.dart';
import '../../../../core/domain/repositories/menu_config_repository.dart';

abstract class ISaveMenuConfigUseCase {
  Future<bool> call(MenuConfigDto menuConfigDto);
}

class SaveMenuConfigUseCase implements ISaveMenuConfigUseCase {
  final IMenuConfigRepository _repository;

  SaveMenuConfigUseCase(this._repository);

  @override
  Future<bool> call(MenuConfigDto menuConfigDto) async {
    return await _repository.save(menuConfigDto);
  }
}
