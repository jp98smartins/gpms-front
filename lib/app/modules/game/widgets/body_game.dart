import 'package:flutter/material.dart';
import 'package:gpms/app/modules/game/widgets/player_card_black.dart';
import 'package:gpms/app/modules/game/widgets/player_card_white.dart';
import 'package:gpms/app/modules/game/widgets/turn_card.dart';

import '../game_controller.dart';
import 'chess_board.dart';

class BodyGame extends StatelessWidget {
  const BodyGame({Key? key, required this.controller}) : super(key: key);

  final GameController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        // Card do Turno do Jogo
        TurnCard(),
        SizedBox(
          height: 25,
        ),
        // Card do Jogador de Pretas
        PlayerCardBlack(),
        SizedBox(
          height: 30,
        ),
        // Tabuleiro
        ChessBoard(),
        SizedBox(
          height: 0,
        ),
        // Card do Jogador de Brancas
        PlayerCardWhite(),
        SizedBox(
          height: 60,
        ),
      ],
    );
  }
}
