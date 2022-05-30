import 'package:flutter_modular/flutter_modular.dart';

import '../../core/domain/repositories/menu_config_repository.dart';
import 'domain/usecases/save_menu_config_usecase.dart';
import 'menu_controller.dart';
import 'menu_page.dart';

class MenuModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => SaveMenuConfigUseCase(i<IMenuConfigRepository>())),
    Bind.factory((i) => MenuController(i<ISaveMenuConfigUseCase>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => MenuPage()),
  ];
}
