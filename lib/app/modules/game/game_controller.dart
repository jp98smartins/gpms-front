import 'dart:developer';

import 'package:get/get.dart';

import '../../core/data/dtos/menu_config_dto.dart';
import 'domain/usecases/fetch_menu_config_usecase.dart';

class GameController extends GetxController {
  final IFetchMenuConfigUseCase _fetchMenuConfigUseCase;

  GameController(this._fetchMenuConfigUseCase);

  late final MenuConfigDto menuConfigDto;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool newState) {
    _isLoading = newState;
    update();
  }

  @override
  void onReady() async {
    super.onReady();
    await fetchMenuConfigs();
  }

  Future<void> fetchMenuConfigs() async {
    isLoading = true;
    try {
      final menuConfig = await _fetchMenuConfigUseCase();

      if (menuConfig == null) {
        menuConfigDto = MenuConfigDto.fromMap({
          "game_mode": "1",
          "game_difficulty": "0",
        });
      } else {
        menuConfigDto = menuConfig;
      }
    } catch (e) {
      log("[ GameController.fetchMenuConfigs() ] => $e");
      // Snackbar
    } finally {
      isLoading = false;
    }
  }

  Future<void> finishGame() async {
    isLoading = true;
    try {} catch (e) {
      log("[ GameController.finishGame() ] => $e");
      // Snackbar
    } finally {
      isLoading = false;
    }
  }
}
