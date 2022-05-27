import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

import '../../core/data/dtos/menu_config_dto.dart';
import '../../core/routes/app_routes.dart';
import 'domain/usecases/save_menu_config_usecase.dart';

class MenuController extends GetxController {
  final ISaveMenuConfigUseCase _saveMenuConfigUseCase;

  MenuController(this._saveMenuConfigUseCase);

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool newState) {
    _isLoading = newState;
    update();
  }

  Future<void> saveConfigs(Map<String, String> configData) async {
    isLoading = true;
    try {
      final isSaved = await _saveMenuConfigUseCase(
        MenuConfigDto.fromMap(configData),
      );

      if (isSaved) {
        Modular.to.popAndPushNamed(AppRoutes.gameRoute);
      }
    } catch (e) {
      log("[ MenuController.saveConfigs() ] => $e");
      // Snackbar
    } finally {
      isLoading = false;
    }
  }
}
