import 'dart:convert';

import '../../../modules/menu/domain/entities/menu_config_entity.dart';
import '../../enums/game_difficulty.dart';
import '../../enums/game_mode.dart';

class MenuConfigDto extends MenuConfigEntity {
  final GameMode gameModeDto;
  final GameDifficulty gameDifficultyDto;

  MenuConfigDto({
    required this.gameModeDto,
    required this.gameDifficultyDto,
  }) : super(gameMode: gameModeDto, gameDifficulty: gameDifficultyDto);

  factory MenuConfigDto.fromMap(Map map) {
    return MenuConfigDto(
      gameModeDto: gameModeFromIndex(
        int.tryParse(map['game_mode'].toString()) ?? 0,
      ),
      gameDifficultyDto: gameDifficultyFromIndex(
        int.tryParse(map['game_difficulty'].toString()) ?? 0,
      ),
    );
  }

  static Map toMap(MenuConfigDto menuConfigDto) {
    return {
      'game_mode': menuConfigDto.gameModeDto.index,
      'game_difficulty': menuConfigDto.gameDifficultyDto.index,
    };
  }

  static String toJson(MenuConfigDto menuConfigDto) => jsonEncode(
        MenuConfigDto.toMap(menuConfigDto),
      );
  factory MenuConfigDto.fromJson(String json) => MenuConfigDto.fromMap(
        jsonDecode(json),
      );
}
