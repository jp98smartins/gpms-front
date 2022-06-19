import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../domain/entities/chess/chess_match.dart';
import '../domain/entities/chess_piece_entity.dart';
import '../domain/functions/find_piece.dart';
import '../domain/functions/generate_all_legal_moviments.dart';
import '../domain/functions/validate_legal_moviments.dart';
import '../domain/functions/verify_location_in_list.dart';
import '../domain/functions/verify_moviment.dart';
import '../game_controller.dart';
import 'chess_board_tile.dart';

class ChessBoard extends StatefulWidget {
  const ChessBoard({Key? key, required this.controller}) : super(key: key);

  final GameController controller;

  @override
  State<ChessBoard> createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  late final ChessMatch chessMatch;
  late final List<ChessPiece> itensTabuleiro;
  bool primeiraTurno = true;
  var pecaAnterior = -1;
  Location ultimo = Location(-1, -1);

  var posicoesY = ['', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
  var posicoesX = ['8', '7', '6', '5', '4', '3', '2', '1', ''];
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

    var possivelPecaAtual = findPiece(itensTabuleiro, Location(x, y));
    if (primeiraTurno) {
      GenerateAllLegalMoviments.gerarMovimentos(itensTabuleiro);
      validate_legal_moviments.validateLegalMoviments(itensTabuleiro);
      primeiraTurno = false;
    }

    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(
        (states) => (ultimo.x == x && ultimo.y == y ||
                verifyLocationInList(posicoesPossiveisEscolha, Location(x, y)))
            ? Colors.red.withOpacity(0.6)
            : Colors.black.withOpacity(0.0),
      )),
      onPressed: () {
        var pieceCheck = chessMatch.isValidColor(
          possivelPecaAtual?.pieceColor,
          chessMatch.pieceColor,
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

          final possivelPecaAntiga = findPiece(itensTabuleiro, ultimo);
          if (possivelPecaAntiga != null) {
            if (VerifyMoviment.verifyMoviment(
              possivelPecaAntiga.legalMoviments,
              Location(x, y),
              itensTabuleiro,
              chessMatch.pecasMortas,
            )) {
              possivelPecaAntiga.location.x = x;
              possivelPecaAntiga.location.y = y;
              possivelPecaAntiga.moved = true;

              chessMatch.addTurn();
              chessMatch.changeCurrentPlayer();
              GenerateAllLegalMoviments.gerarMovimentos(itensTabuleiro);
              validate_legal_moviments.validateLegalMoviments(itensTabuleiro);
              if (chessMatch.currentPlayer == "Pretas") {
                validate_legal_moviments.validateWinner(
                    itensTabuleiro, PieceColor.black);
              } else {
                validate_legal_moviments.validateWinner(
                    itensTabuleiro, PieceColor.white);
              }
              widget.controller.update();
            }
          }

          //GenerateAllLegalMoviments.gerarMovimentos(itensTabuleiro);
          //log("Generate Moviment 2");
          // RESETA AS POSSIVEIS OPÇÕES DE ESCOLHA
          posicoesPossiveisEscolha = null;
          ultimo.x = -1;
          ultimo.y = -1;
        }

        setState(() {});
        Modular.get<GameController>().update();
      },
      child: Center(
        child: findPiece(itensTabuleiro, Location(x, y)) == null
            ? null
            : possivelPecaAtual!.image,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    chessMatch = widget.controller.chessMatch;
    itensTabuleiro = widget.controller.itensTabuleiro;
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
