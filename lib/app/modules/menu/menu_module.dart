import 'package:flutter_modular/flutter_modular.dart';

import 'bloc/menu_bloc.dart';
import 'menu_page.dart';

class MenuModule extends Module {
  @override
  final List<Bind> binds = [Bind.lazySingleton((i) => MenuBloc())];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const MenuPage()),
  ];
}
