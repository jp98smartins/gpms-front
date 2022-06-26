// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import '../chess_piece_entity.dart';

enum MatchResult { black, white, draw }

class ChessMatch {
  bool inGame;
  int turn;
  List<ChessPiece> pecasMortas;
  String currentPlayer;
  PieceColor pieceColor;
  MatchResult? matchResult;
  ChessMatch({
    required this.inGame,
    required this.turn,
    required this.pecasMortas,
    required this.currentPlayer,
    required this.pieceColor,
    required this.matchResult,
  });

  addTurn() {
    turn++;
  }

  changeCurrentPlayer() {
    if (turn.isEven) {
      currentPlayer = 'Pretas';
      pieceColor = PieceColor.black;
    } else {
      currentPlayer = 'Brancas';
      pieceColor = PieceColor.white;
    }

    // log(currentPlayer);
    // log('$turn');
  }

  addPecasMortas(ChessPiece pecaMorta) {
    pecasMortas.add(pecaMorta);
  }

  String finishGame(PieceColor pieceColor) {
    inGame = false;
    if (pieceColor == PieceColor.white) {
      return 'Vitória das Brancas';
    } else {
      return 'Vitória das Pretas';
    }
  }

  bool? isValidColor(PieceColor? currentlyPiece, PieceColor playerPieceColor) {
    if (currentlyPiece == playerPieceColor) {
      return true;
    }
    return false;
  }
}
