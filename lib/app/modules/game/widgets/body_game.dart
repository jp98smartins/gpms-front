import 'package:flutter/material.dart';
import 'package:gpms/app/modules/game/widgets/player_card.dart';
import 'package:gpms/app/modules/game/widgets/turn_card.dart';

import '../game_controller.dart';
import 'chess_board.dart';

class BodyGame extends StatefulWidget {
  const BodyGame({Key? key, required this.controller}) : super(key: key);
  final GameController controller;
  @override
  State<BodyGame> createState() => _BodyGameState();
}

class _BodyGameState extends State<BodyGame> {
  update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Card do Turno do Jogo
        TurnCard(
          chessMatch: widget.controller.chessMatch,
        ),
        const SizedBox(
          height: 25,
        ),
        // Card do Jogador de Pretas
        PlayerCard(
          pecasMortas: widget.controller.pecasMortas,
          color: "black",
          itensTabuleiro: widget.controller.itensTabuleiro,
        ),
        const SizedBox(
          height: 25,
        ),
        // Tabuleiro
        ChessBoard(
          chessMatch: widget.controller.chessMatch,
          itensTabuleiro: widget.controller.itensTabuleiro,
          updateAll: update,
        ),
        const SizedBox(
          height: 0,
        ),
        // Card do Jogador de Brancas
        PlayerCard(
          pecasMortas: widget.controller.pecasMortas,
          color: "white",
          itensTabuleiro: widget.controller.itensTabuleiro,
        ),
        const SizedBox(
          height: 55,
        ),
      ],
    );
  }
}
