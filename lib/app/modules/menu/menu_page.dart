import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import 'menu_controller.dart';
import 'widgets/body_menu.dart';

class MenuPage extends StatelessWidget {
  MenuPage({Key? key}) : super(key: key);

  final controller = Modular.get<MenuController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: GetBuilder<MenuController>(
              init: Modular.get<MenuController>(),
              builder: (_) => Center(
                child: BodyMenu(key: const Key("BodyMenu")),
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }
}
