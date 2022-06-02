import 'package:flutter/material.dart';
import 'package:gpms/app/modules/game/widgets/player_card.dart';
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
      children: [
        // Card do Turno do Jogo
        TurnCard(
          chessMatch: controller.chessMatch,
        ),
        const SizedBox(
          height: 25,
        ),
        // Card do Jogador de Pretas
        PlayerCard(
          pecasMortas: controller.pecasMortas,
          color: "black",
          itensTabuleiro: controller.itensTabuleiro,
        ),
        const SizedBox(
          height: 25,
        ),
        // Tabuleiro
        ChessBoard(
          chessMatch: controller.chessMatch,
          itensTabuleiro: controller.itensTabuleiro,
        ),
        const SizedBox(
          height: 0,
        ),
        // Card do Jogador de Brancas
        PlayerCard(
          pecasMortas: controller.pecasMortas,
          color: "white",
          itensTabuleiro: controller.itensTabuleiro,
        ),
        const SizedBox(
          height: 55,
        ),
      ],
    );
  }
}
