import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:gpms/app/core/theme/app_colors.dart';
import 'package:gpms/app/modules/game/domain/entities/chess/chess_match.dart';
import 'package:gpms/app/modules/game/domain/functions/verify_moviment.dart';
import 'package:gpms/app/modules/game/game_controller.dart';
import 'package:gpms/app/modules/game/widgets/turn_card.dart';

import '../domain/entities/chess_piece_entity.dart';
import '../domain/functions/find_piece.dart';
import '../domain/functions/generate_all_legal_moviments.dart';
import '../domain/functions/verify_location_in_list.dart';
import 'chess_board_tile.dart';

class ChessBoard extends StatefulWidget {
  ChessBoard({
    Key? key,
    required this.chessMatch,
    required this.itensTabuleiro,
    required this.updateAll,
  }) : super(key: key);
  ChessMatch chessMatch;
  final List<ChessPiece> itensTabuleiro;
  final VoidCallback updateAll;

  @override
  State<ChessBoard> createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  var pecaAnterior = -1;
  Location ultimo = Location(-1, -1);

  var posicoesY = ['', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
  var posicoesX = ['1', '2', '3', '4', '5', '6', '7', '8', ''];
  List<Location>? posicoesPossiveisEscolha;

  /// Method that picks the right color for the position on the board.
  ///
  /// @param [int x] position x of the board.
  /// @param [int y] position y of the board.
  ///
  /// @return Color [ AppColors.backgroundPrimary, AppColors.lightBoardPosition, AppColors.darkBoardPosition ]
  Color pickBoardPositionColor(int x, int y) {
    // Cor das Letras/Números das casas do tabuleiro
    if (x == 0 || y == 8) return AppColors.backgroundPrimary;

    // Casas Claras do Tabuleiro
    if ((x.isEven && y.isOdd) || (x.isOdd && y.isEven)) {
      return AppColors.lightBoardPosition;
    }

    // Casas Escuras do Tabuleiro
    return AppColors.darkBoardPosition;
  }

  Widget? escolheContainerFilho(int x, int y) {
    //definição linha e coluna
    if (x == 0) {
      return Center(
        child: Text(
          posicoesX[y],
          style: Theme.of(context).textTheme.caption,
        ),
      );
    }
    if (y == 8) {
      return Center(
        child: Text(
          posicoesY[x],
          style: Theme.of(context).textTheme.caption,
        ),
      );
    }

    var possivelPecaAtual = findPiece(widget.itensTabuleiro, Location(x, y));
    GenerateAllLegalMoviments.gerarMovimentos(widget.itensTabuleiro);
    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(
        (states) => (ultimo.x == x && ultimo.y == y ||
                verifyLocationInList(posicoesPossiveisEscolha, Location(x, y)))
            ? Colors.red.withOpacity(0.6)
            : Colors.black.withOpacity(0.0),
      )),
      onPressed: () {
        var pieceCheck = widget.chessMatch.isValidColor(
          possivelPecaAtual?.pieceColor,
          widget.chessMatch.pieceColor,
        );
        if (ultimo.x == -1 &&
            ultimo.y == -1 &&
            possivelPecaAtual != null &&
            pieceCheck == true) {
          ultimo.x = x;
          ultimo.y = y;

          posicoesPossiveisEscolha = possivelPecaAtual.legalMoviments;
        } else {
          // VERIFICA SE TEM PEÇA ANTIGA, CASO TENHA COLOCA NA NOVA POSICAO

          final possivelPecaAntiga = findPiece(widget.itensTabuleiro, ultimo);
          if (possivelPecaAntiga != null) {
            if (VerifyMoviment.verifyMoviment(
                possivelPecaAntiga.legalMoviments,
                Location(x, y),
                widget.itensTabuleiro,
                widget.chessMatch.pecasMortas)) {
              possivelPecaAntiga.location.x = x;
              possivelPecaAntiga.location.y = y;
              possivelPecaAntiga.moved = true;
              widget.chessMatch.addTurn();
              widget.chessMatch.changeCurrentPlayer();
              widget.updateAll();
            }
          }

          // RESETA AS POSSIVEIS OPÇÕES DE ESCOLHA
          posicoesPossiveisEscolha = null;
          ultimo.x = -1;
          ultimo.y = -1;
        }
        setState(() {});
        Modular.get<GameController>().update();
      },
      child: Center(
        child: findPiece(widget.itensTabuleiro, Location(x, y)) == null
            ? null
            : possivelPecaAtual!.image,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.width,
      child: Column(
        children: List.generate(
          9,
          (y) => Row(
            children: [
              ...List.generate(
                9,
                (x) => BoardPositionTile(
                  color: pickBoardPositionColor(x, y),
                  child: escolheContainerFilho(x, y),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
