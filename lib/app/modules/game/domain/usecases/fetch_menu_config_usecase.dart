import '../../../../core/data/dtos/menu_config_dto.dart';
import '../../../../core/domain/repositories/menu_config_repository.dart';

abstract class IFetchMenuConfigUseCase {
  Future<MenuConfigDto?> call();
}

class FetchMenuConfigUseCase implements IFetchMenuConfigUseCase {
  final IMenuConfigRepository _repository;

  FetchMenuConfigUseCase(this._repository);

  @override
  Future<MenuConfigDto?> call() async {
    return await _repository.fecht();
  }
}
