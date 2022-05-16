import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../../core/enums/game_difficulty.dart';
import '../../../../core/enums/game_type.dart';
import '../../domain/entities/menu_config_entity.dart';

class MenuConfigDto extends MenuConfigEntity {
  final GameType gameTypeDto;
  final GameDifficulty gameDifficultyDto;

  MenuConfigDto({
    required this.gameTypeDto,
    required this.gameDifficultyDto,
  }) : super(gameType: gameTypeDto, gameDifficulty: gameDifficultyDto);

  factory MenuConfigDto.fromMap(Map map) {
    return MenuConfigDto(
      gameTypeDto: gameTypeFromIndex(map['game_type']),
      gameDifficultyDto: gameDifficultyFromIndex(map['game_difficulty']),
    );
  }

  static Map toMap(MenuConfigDto menuConfigDto) {
    return {
      'game_type': menuConfigDto.gameTypeDto.index,
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
