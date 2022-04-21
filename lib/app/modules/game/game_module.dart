import 'package:flutter_modular/flutter_modular.dart';

import 'bloc/game_bloc.dart';
import 'game_page.dart';

class GameModule extends Module {
  @override
  final List<Bind> binds = [Bind.lazySingleton((i) => GameBloc())];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const GamePage()),
  ];
}
