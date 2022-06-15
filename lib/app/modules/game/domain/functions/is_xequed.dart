import 'dart:developer';

import '../entities/chess_piece_entity.dart';
import 'find_piece.dart';

class is_xequed {
  static bool isXequed(List<ChessPiece> tabuleiro) {
    //PEGA A POSIÇÃO ATUAL DOS KINGS
    for (var piece in tabuleiro) {
      if (piece.legalMoviments != null) {
        for (var legalMoviment in piece.legalMoviments!) {
          var piece = findPiece(tabuleiro, legalMoviment);
          if (piece != null) {
            if (piece.name == 'king') {
              log('xequed');
              return true;
            }
          }
        }
      }
    }
    return false;
  }
}
