import 'package:flutter_modular/flutter_modular.dart';

import 'core/routes/app_routes.dart';
import 'modules/game/game_module.dart';
import 'modules/menu/menu_module.dart';
import 'modules/splash/splash_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(AppRoutes.initialRoute, module: SplashModule()),
    ModuleRoute(AppRoutes.menuRoute, module: MenuModule()),
    ModuleRoute(AppRoutes.gameRoute, module: GameModule()),
  ];
}
