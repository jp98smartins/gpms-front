import 'dart:developer';

import '../entities/chess_piece_entity.dart';
import 'find_piece.dart';

class is_xequed {
  static ChessPiece? getXequed(List<ChessPiece> tabuleiro) {
    for (ChessPiece piece in tabuleiro) {
      if (piece.legalMoviments != null) {
        for (var legalMoviment in piece.legalMoviments!) {
          ChessPiece? piece2 = findPiece(tabuleiro, legalMoviment);
          if (piece2 != null) {
            if (piece2.name == 'king' &&
                piece.pieceColor != piece2.pieceColor) {
              log('xequed');
              return piece2;
            }
          }
        }
      }
    }
    return null;
  }

  static bool isXequed(List<ChessPiece> tabuleiro) {
    return (getXequed(tabuleiro) != null);
  }
}
