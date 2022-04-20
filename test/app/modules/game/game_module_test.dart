import 'package:modular_test/modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gpms/app/modules/game/game_module.dart';

void main() {
  setUpAll(() {
    initModule(GameModule());
  });
}
