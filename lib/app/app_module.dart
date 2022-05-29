import 'package:flutter_modular/flutter_modular.dart';
import 'package:gpms/app/core/adapters/local_storage_adapter.dart';

import 'core/data/providers/menu_config_provider.dart';
import 'core/data/repositories/menu_config_repository_imple.dart';
import 'core/routes/app_routes.dart';
import 'modules/game/game_module.dart';
import 'modules/menu/menu_module.dart';
import 'modules/splash/splash_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LocalStorageAdapter(boxName: "menu_config")),
    Bind.lazySingleton((i) => MenuConfigProvider(i<ILocalStorage>())),
    Bind.lazySingleton((i) => MenuConfigRepository(i<IMenuConfigProvider>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(AppRoutes.initialRoute, module: SplashModule()),
    ModuleRoute(AppRoutes.menuRoute, module: MenuModule()),
    ModuleRoute(AppRoutes.gameRoute, module: GameModule()),
  ];
}
