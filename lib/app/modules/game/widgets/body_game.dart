import 'package:flutter/material.dart';

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
        // Card do Jogador de Pretas
        ChessBoard(),
        // Card do Jogador de Brancas
      ],
    );
  }
}
