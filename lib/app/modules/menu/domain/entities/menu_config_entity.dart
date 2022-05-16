import '../../../../core/enums/game_difficulty.dart';
import '../../../../core/enums/game_type.dart';

class MenuConfigEntity {
  final GameType gameType;
  final GameDifficulty gameDifficulty;

  MenuConfigEntity({required this.gameType, required this.gameDifficulty});
}
