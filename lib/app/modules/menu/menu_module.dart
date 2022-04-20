import 'package:gpms/app/modules/menu/menu_Page.dart';
import 'package:gpms/app/modules/menu/bloc/menu_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MenuModule extends Module {
  @override
  final List<Bind> binds = [Bind.lazySingleton((i) => MenuBloc())];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const MenuPage()),
  ];
}
