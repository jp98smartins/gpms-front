import 'package:flutter/material.dart';

import '../game_controller.dart';
import 'chess_board.dart';
import 'player_card.dart';
import 'turn_card.dart';

class BodyGame extends StatelessWidget {
  const BodyGame({Key? key, required this.controller}) : super(key: key);

  final GameController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 5),
        // Card do Turno do Jogo
        TurnCard(chessMatch: controller.chessMatch),
        const SizedBox(height: 5),
        // Card do Jogador de Pretas
        PlayerCard(
          color: "black",
          diedPieces: controller.chessMatch.pecasMortas,
        ),
        const SizedBox(height: 5),
        // Tabuleiro
        ChessBoard(controller: controller),
        const SizedBox(height: 5),
        // Card do Jogador de Brancas
        PlayerCard(
          color: "white",
          diedPieces: controller.chessMatch.pecasMortas,
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
