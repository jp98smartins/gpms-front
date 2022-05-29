import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

import 'domain/usecases/fetch_menu_config_usecase.dart';

class GameController extends GetxController {
  final IFetchMenuConfigUseCase _fetchMenuConfigUseCase;

  GameController(this._fetchMenuConfigUseCase);

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool newState) {
    _isLoading = newState;
    update();
  }

  Future<void> fetchMenuConfigs(BuildContext context) async {
    isLoading = true;
    try {
      final menuConfig = await _fetchMenuConfigUseCase();

      if (menuConfig != null) {
        showDialog(
          context: context,
          builder: (c) {
            return AlertDialog(
              insetPadding: const EdgeInsets.symmetric(vertical: 200.0),
              title: const Text("Menu Configs"),
              content: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Text("Modo de Jogo: ${menuConfig.gameMode.name}"),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Dificuldade do Jogo: ${menuConfig.gameDifficulty.name}",
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Modular.to.pop(),
                  child: const Text("ok"),
                ),
              ],
              actionsAlignment: MainAxisAlignment.center,
            );
          },
        );
      }
    } catch (e) {
      log("[ GameController.fetchMenuConfigs() ] => $e");
      // Snackbar
    } finally {
      isLoading = false;
    }
  }
}
