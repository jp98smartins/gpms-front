import 'package:gpms/app/modules/game/game_Page.dart';
import 'package:gpms/app/modules/game/bloc/game_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GameModule extends Module {
  @override
  final List<Bind> binds = [Bind.lazySingleton((i) => GameBloc())];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const GamePage()),
  ];
}
