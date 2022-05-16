import '../../data/dtos/menu_config_dto.dart';

abstract class IFetchMenuConfigUseCase {
  Future<MenuConfigDto?> call();
}

class FetchMenuConfigUseCase implements IFetchMenuConfigUseCase {
  @override
  Future<MenuConfigDto?> call() async {
    throw UnimplementedError();
  }
}
