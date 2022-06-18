import 'dart:developer';

import 'package:gpms/app/modules/game/domain/entities/chess/chess_match.dart';
import 'package:gpms/app/modules/game/domain/functions/verify_moviment.dart';

import 'generate_all_legal_moviments.dart';
import 'is_xequed.dart';
import '../entities/chess_piece_entity.dart';

class validate_legal_moviments {
  static void validateLegalMoviments(List<ChessPiece> tabuleiro) {
    List<Location> removeIlegalMoviments = [Location(-1, -1)];
    List<Location> removeLocations = [Location(-1, -1)];
    if (is_xequed.isXequed(tabuleiro)) {
      //AQUI A CRIANÇA CHORA E O PAI NÃO VÊ
      for (var piece in tabuleiro) {
        if (piece.legalMoviments != null) {
          for (var legalMoviment in piece.legalMoviments!) {
            var oldLocation = piece.location;

            ChessPiece? ult;
            Location? ultLocation;

            //verificar se a nova localização, mata alguem
            for (ChessPiece piece in tabuleiro) {
              if (piece.location.x == legalMoviment.x &&
                  piece.location.y == legalMoviment.y) {
                ult = piece;
                ultLocation = piece.location;
                piece.location = Location(-1, -1);
              }
            }
            piece.location = legalMoviment;

            GenerateAllLegalMoviments.gerarMovimentos(tabuleiro);
            if (is_xequed.isXequed(tabuleiro)) {
              piece.addIlegalMoviments(legalMoviment);
            }

            piece.location = oldLocation;
            ult?.location = ultLocation!;

            //GenerateAllLegalMoviments.gerarMovimentos(tabuleiro);
          }
        }
      }

      GenerateAllLegalMoviments.gerarMovimentosNEW(tabuleiro, removeLocations);
      for (ChessPiece piece in tabuleiro) {
        if (piece.ilegalMoviments != null) {
          for (Location location in piece.ilegalMoviments!) {
            removeIlegalMoviments.add(location);
          }
        }
      }

      limpailegalMoviments(tabuleiro, removeIlegalMoviments);
      //log("New move");
    } else {
      //AQUI A GENTE É FELIZ
    }
  }

  static void limpailegalMoviments(
      List<ChessPiece> tabuleiro, List<Location>? remove) {
    for (ChessPiece piece in tabuleiro) {
      if (piece.ilegalMoviments != null) {
        if (remove != null) {
          for (Location location in remove) {
            piece.ilegalMoviments!.remove(location);
          }
        }
      }
    }
  }

  static void validateWinner(List<ChessPiece> tabuleiro, PieceColor color) {
    int cont = 0;
    if (is_xequed.isXequed(tabuleiro)) {
      for (ChessPiece piece in tabuleiro) {
        if (piece.pieceColor == color) {
          if (piece.legalMoviments == null) {
            cont += 1;
          }
        }
      }
    }
    if (cont >= 16) {
      if (color == PieceColor.black) {
        log("Brancas Win");
      } else {
        log("Pretas Win");
      }
    }
  }
}
