import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpms/app/core/theme/app_colors.dart';
import 'package:gpms/app/modules/game/domain/functions/verify_moviment.dart';

import '../domain/entities/bishop_entity.dart';
import '../domain/entities/chess_piece_entity.dart';
import '../domain/entities/king_entity.dart';
import '../domain/entities/knight_entity.dart';
import '../domain/entities/pawn_entity.dart';
import '../domain/entities/queen_entity.dart';
import '../domain/entities/rook_entity.dart';
import '../domain/functions/find_piece.dart';
import '../domain/functions/generate_all_legal_moviments.dart';
import '../domain/functions/verify_location_in_list.dart';
import 'chess_board_tile.dart';

class ChessBoard extends StatefulWidget {
  const ChessBoard({Key? key}) : super(key: key);

  @override
  State<ChessBoard> createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  var pecaAnterior = -1;
  Location ultimo = Location(-1, -1);

  List<ChessPiece> itensTabuleiro = [
    Rook(PieceColor.black, Location(1, 0)),
    Knight(PieceColor.black, Location(2, 0)),
    Bishop(PieceColor.black, Location(3, 0)),
    Queen(PieceColor.black, Location(4, 0)),
    King(PieceColor.black, Location(5, 0)),
    Bishop(PieceColor.black, Location(6, 0)),
    Knight(PieceColor.black, Location(7, 0)),
    Rook(PieceColor.black, Location(8, 0)),
    Pawn(PieceColor.black, Location(1, 1)),
    Pawn(PieceColor.black, Location(3, 1)),
    Pawn(PieceColor.black, Location(4, 1)),
    Pawn(PieceColor.black, Location(5, 1)),
    Pawn(PieceColor.black, Location(2, 1)),
    Pawn(PieceColor.black, Location(6, 1)),
    Pawn(PieceColor.black, Location(7, 1)),
    Pawn(PieceColor.black, Location(8, 1)),
    Pawn(PieceColor.white, Location(1, 6)),
    Pawn(PieceColor.white, Location(2, 6)),
    Pawn(PieceColor.white, Location(3, 6)),
    Pawn(PieceColor.white, Location(4, 6)),
    Pawn(PieceColor.white, Location(5, 6)),
    Pawn(PieceColor.white, Location(6, 6)),
    Pawn(PieceColor.white, Location(7, 6)),
    Pawn(PieceColor.white, Location(8, 6)),
    Rook(PieceColor.white, Location(1, 7)),
    Knight(PieceColor.white, Location(2, 7)),
    Bishop(PieceColor.white, Location(3, 7)),
    Queen(PieceColor.white, Location(4, 7)),
    King(PieceColor.white, Location(5, 7)),
    Bishop(PieceColor.white, Location(6, 7)),
    Knight(PieceColor.white, Location(7, 7)),
    Rook(PieceColor.white, Location(8, 7)),
  ];
  List<ChessPiece> pecasMortas = [];
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

    var possivelPecaAtual = findPiece(itensTabuleiro, Location(x, y));
    GenerateAllLegalMoviments.gerarMovimentos(itensTabuleiro);
    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(
        (states) => (ultimo.x == x && ultimo.y == y ||
                verifyLocationInList(posicoesPossiveisEscolha, Location(x, y)))
            ? Colors.red.withOpacity(0.6)
            : Colors.black.withOpacity(0.0),
      )),
      onPressed: () {
        if (ultimo.x == -1 && ultimo.y == -1 && possivelPecaAtual != null) {
          ultimo.x = x;
          ultimo.y = y;

          posicoesPossiveisEscolha = possivelPecaAtual.legalMoviments;
        } else {
          // VERIFICA SE TEM PEÇA ANTIGA, CASO TENHA COLOCA NA NOVA POSICAO

          final possivelPecaAntiga = findPiece(itensTabuleiro, ultimo);
          if (possivelPecaAntiga != null) {
            if (VerifyMoviment.verifyMoviment(possivelPecaAntiga.legalMoviments,
                Location(x, y), itensTabuleiro, pecasMortas)) {
              possivelPecaAntiga.location.x = x;
              possivelPecaAntiga.location.y = y;
              possivelPecaAntiga.moved = true;
            }
          }

          // RESETA AS POSSIVEIS OPÇÕES DE ESCOLHA
          posicoesPossiveisEscolha = null;
          ultimo.x = -1;
          ultimo.y = -1;
        }
        setState(() {});
      },
      child: Center(
        child: findPiece(itensTabuleiro, Location(x, y)) == null
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
