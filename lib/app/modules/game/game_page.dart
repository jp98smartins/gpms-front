import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/adapters/svg_image_adapter.dart';
import '../../core/theme/app_assets.dart';
import 'widgets/body_game.dart';
import 'game_controller.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: GetBuilder<GameController>(
            init: Modular.get<GameController>(),
            builder: (controller) => Center(
              child: Scaffold(
                appBar: AppBar(
                  leading: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgImageAdapter.fromAsset(AppAssets.whiteIcon),
                  ),
                  title: const Text("xadrez"),
                  actions: [
                    PopupMenuButton<String>(
                      onSelected: (value) => {controller.finishDialog(context)},
                      itemBuilder: (BuildContext context) {
                        return {'Finalizar Partida'}.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                    ),
                  ],
                ),
                body: BodyGame(
                  key: const Key("BodyGame"),
                  controller: controller,
                ),
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }
}
