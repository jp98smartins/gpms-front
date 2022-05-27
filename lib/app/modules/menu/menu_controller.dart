import 'package:get/get.dart';


class MenuController extends GetxController {
  // Usecases Here!

  MenuController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool newState) {
    _isLoading = newState;
    update();
  }
}

