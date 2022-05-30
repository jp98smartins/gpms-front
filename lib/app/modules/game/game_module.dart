import 'package:flutter_modular/flutter_modular.dart';

import '../../core/domain/repositories/menu_config_repository.dart';
import 'domain/usecases/fetch_menu_config_usecase.dart';
import 'game_controller.dart';
import 'game_page.dart';

class GameModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => FetchMenuConfigUseCase(i<IMenuConfigRepository>())),
    Bind.factory((i) => GameController(i<IFetchMenuConfigUseCase>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const GamePage()),
  ];
}
