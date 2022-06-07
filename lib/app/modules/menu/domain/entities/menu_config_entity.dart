import '../../../../core/enums/game_difficulty.dart';
import '../../../../core/enums/game_mode.dart';

class MenuConfigEntity {
  final GameMode gameMode;
  final GameDifficulty gameDifficulty;

  MenuConfigEntity({required this.gameMode, required this.gameDifficulty});
}
