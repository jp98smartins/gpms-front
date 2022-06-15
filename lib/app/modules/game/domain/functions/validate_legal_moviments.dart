import 'dart:developer';

import 'generate_all_legal_moviments.dart';
import 'is_xequed.dart';
import '../entities/chess_piece_entity.dart';

class validate_legal_moviments {
  static void validateLegalMoviments(List<ChessPiece> tabuleiro) {
    List<Location> removeLocations = [Location(-1, -1)];
    if (is_xequed.isXequed(tabuleiro)) {
      //AQUI A CRIANÇA CHORA E O PAI NÃO VÊ
      for (var piece in tabuleiro) {
        if (piece.legalMoviments != null) {
          for (var legalMoviment in piece.legalMoviments!) {
            var old_location = piece.location;
            piece.location = legalMoviment;
            GenerateAllLegalMoviments.gerarMovimentos(tabuleiro);
            if (is_xequed.isXequed(tabuleiro)) {
              removeLocations.add(legalMoviment);
            }
            piece.location = old_location;
            GenerateAllLegalMoviments.gerarMovimentos(tabuleiro);
          }
        }
      }
      for (var piece in tabuleiro) {
        if (piece.legalMoviments != null) {
          for (var location in removeLocations) {
            piece.remLegalMoviments(location);
          }
        }
      }
    } else {
      //AQUI A GENTE É FELIZ
    }
  }
}
