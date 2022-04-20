import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import 'bloc/menu_bloc.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  MenuPageState createState() => MenuPageState();
}

class MenuPageState extends State<MenuPage> {
  final MenuBloc bloc = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menu")),
      body: Column(children: const <Widget>[]),
    );
  }
}
