import 'package:get/get.dart';


class GameController extends GetxController {
  // Usecases Here!

  GameController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool newState) {
    _isLoading = newState;
    update();
  }
}

