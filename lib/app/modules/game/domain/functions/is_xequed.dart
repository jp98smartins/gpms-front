import 'dart:developer';

import '../entities/chess_piece_entity.dart';
import 'find_piece.dart';

class is_xequed {
  static ChessPiece? getXequed(List<ChessPiece> tabuleiro) {
    for (ChessPiece piece in tabuleiro) {
      if (piece.opMoviments != null) {
        for (var opMoviment in piece.opMoviments!) {
          ChessPiece? piece2 = findPiece(tabuleiro, opMoviment);
          if (piece2 != null) {
            if (piece2.name == 'king' &&
                piece.pieceColor != piece2.pieceColor &&
                !piece.died) {
              log('xequed');
              return piece2;
            }
          }
        }
      }
      if (piece.legalMoviments != null) {
        for (var legalMoviment in piece.legalMoviments!) {
          ChessPiece? piece2 = findPiece(tabuleiro, legalMoviment);
          if (piece2 != null) {
            if (piece2.name == 'king' &&
                piece.pieceColor != piece2.pieceColor &&
                !piece.died) {
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

  static bool isBothXequed(List<ChessPiece> tabuleiro) {
    bool whiteKingChecked = false;
    bool blackKingChecked = false;
    for (ChessPiece piece in tabuleiro) {
      if (piece.opMoviments != null) {
        for (var opMoviment in piece.opMoviments!) {
          ChessPiece? piece2 = findPiece(tabuleiro, opMoviment);
          if (piece2 != null) {
            if (piece2.name == 'king' &&
                piece.pieceColor != piece2.pieceColor &&
                !piece.died) {
              if (piece2.pieceColor.name == 'white') {
                whiteKingChecked = true;
              } else {
                blackKingChecked = true;
              }
            }
          }
        }
      }
      if (piece.legalMoviments != null) {
        for (var legalMoviment in piece.legalMoviments!) {
          ChessPiece? piece2 = findPiece(tabuleiro, legalMoviment);
          if (piece2 != null) {
            if (piece2.name == 'king' &&
                piece.pieceColor != piece2.pieceColor &&
                !piece.died) {
              if (piece2.pieceColor.name == 'white') {
                whiteKingChecked = true;
              } else {
                blackKingChecked = true;
              }
            }
          }
        }
      }
    }
    return (whiteKingChecked && blackKingChecked);
  }
}
