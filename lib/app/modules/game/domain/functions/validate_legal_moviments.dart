import 'dart:developer';

import 'package:gpms/app/modules/game/domain/entities/chess/chess_match.dart';
import 'package:gpms/app/modules/game/domain/functions/verify_moviment.dart';

import 'generate_all_legal_moviments.dart';
import 'is_xequed.dart';
import 'move.dart';
import '../entities/chess_piece_entity.dart';

class validate_legal_moviments {
  static void validateLegalMoviments(List<ChessPiece> tabuleiro,
      [ChessPiece? lastPiece, Location? oldLocation, Location? newLocation]) {
    List<Location> removeLocations = [Location(-1, -1)];
    GenerateAllLegalMoviments.gerarMovimentosNEW(
        tabuleiro, removeLocations, lastPiece, oldLocation, newLocation);
    for (var i = 0; i < 2; i++) {
      for (var piece in tabuleiro) {
        if (piece.legalMoviments != null) {
          List<Location> locationsForRemove = [];
          for (var legalMoviment in piece.legalMoviments!) {
            if (!Move.isLegalMovement(tabuleiro, piece, legalMoviment)) {
              Location? opForRm;
              if (piece.opMoviments != null) {
                for (var opMoviment in piece.opMoviments!) {
                  if (opMoviment.x == legalMoviment.x &&
                      opMoviment.y == legalMoviment.y) {
                    opForRm = opMoviment;
                    break;
                  }
                }
              }
              if (opForRm != null) {
                piece.remOpMoviments(opForRm);
              }
              locationsForRemove.add(legalMoviment);
            }
          }
          for (var lfr in locationsForRemove) {
            if (piece.legalMoviments != null &&
                piece.legalMoviments!.contains(lfr)) {
              piece.remLegalMoviments(lfr);
            }
            piece.addIlegalMoviments(lfr);
          }
        }
      }
    }
  }

  static void validateLegalMoviments_deprecated(List<ChessPiece> tabuleiro,
      [ChessPiece? lastPiece, Location? oldLocation, Location? newLocation]) {
    List<Location> removeIlegalMoviments = [Location(-1, -1)];
    List<Location> removeLocations = [Location(-1, -1)];
    GenerateAllLegalMoviments.gerarMovimentosNEW(
        tabuleiro, removeLocations, lastPiece, oldLocation, newLocation);
    ChessPiece? xequedKing = is_xequed.getXequed(tabuleiro);

    if (xequedKing != null) {
      for (var piece in tabuleiro) {
        if (piece.legalMoviments != null) {
          for (var legalMoviment in piece.legalMoviments!) {
            var oldLocation = piece.location;

            ChessPiece? ult;
            Location? ultLocation;

            for (ChessPiece killed in tabuleiro) {
              if (killed.location.x == legalMoviment.x &&
                  killed.location.y == legalMoviment.y &&
                  !killed.died) {
                ult = killed;
                ultLocation = killed.location;
                killed.location = Location(-1, -1);
                killed.died = true;
              }
            }
            piece.location = legalMoviment;

            List<ChessPiece> tmpTabuleiro = tabuleiro.toList();
            if (is_xequed.getXequed(tabuleiro)?.pieceColor ==
                    piece.pieceColor ||
                is_xequed.getXequed(tmpTabuleiro)?.pieceColor ==
                    piece.pieceColor) piece.addIlegalMoviments(legalMoviment);

            piece.location = oldLocation;
            ult?.location = ultLocation!;
            ult?.died = false;
          }
        }
      }
    } else {
      for (var piece in tabuleiro) {
        if (piece.legalMoviments != null) {
          for (var legalMoviment in piece.legalMoviments!) {
            var oldLocation = piece.location;
            ChessPiece? ult;
            Location? ultLocation;

            for (ChessPiece piece in tabuleiro) {
              if (piece.location.x == legalMoviment.x &&
                  piece.location.y == legalMoviment.y) {
                ult = piece;
                ultLocation = piece.location;
                piece.location = Location(-1, -1);
              }
            }
            piece.location = legalMoviment;

            List<ChessPiece> tmpTabuleiro = tabuleiro.toList();
            if (is_xequed.getXequed(tabuleiro)?.pieceColor ==
                    piece.pieceColor ||
                is_xequed.getXequed(tmpTabuleiro)?.pieceColor ==
                    piece.pieceColor) piece.addIlegalMoviments(legalMoviment);

            piece.location = oldLocation;
            ult?.location = ultLocation!;
          }
        }
      }
    }

    if (xequedKing != null) {
      for (var piece in tabuleiro) {
        if (piece.legalMoviments != null) {
          for (var legalMoviment in piece.legalMoviments!) {
            var oldLocation = piece.location;

            ChessPiece? ult;
            Location? ultLocation;

            for (ChessPiece killed in tabuleiro) {
              if (killed.location.x == legalMoviment.x &&
                  killed.location.y == legalMoviment.y &&
                  !killed.died) {
                ult = killed;
                ultLocation = killed.location;
                killed.location = Location(-1, -1);
                killed.died = true;
              }
            }
            piece.location = legalMoviment;

            List<ChessPiece> tmpTabuleiro = tabuleiro.toList();
            GenerateAllLegalMoviments.gerarMovimentos(
                tmpTabuleiro, lastPiece, oldLocation, newLocation);
            if (is_xequed.getXequed(tabuleiro)?.pieceColor ==
                    piece.pieceColor ||
                is_xequed.getXequed(tmpTabuleiro)?.pieceColor ==
                    piece.pieceColor) piece.addIlegalMoviments(legalMoviment);

            piece.location = oldLocation;
            ult?.location = ultLocation!;
            ult?.died = false;
          }
        }
      }
    } else {
      for (var piece in tabuleiro) {
        if (piece.legalMoviments != null) {
          for (var legalMoviment in piece.legalMoviments!) {
            var oldLocation = piece.location;
            ChessPiece? ult;
            Location? ultLocation;

            for (ChessPiece piece in tabuleiro) {
              if (piece.location.x == legalMoviment.x &&
                  piece.location.y == legalMoviment.y) {
                ult = piece;
                ultLocation = piece.location;
                piece.location = Location(-1, -1);
              }
            }
            piece.location = legalMoviment;

            List<ChessPiece> tmpTabuleiro = tabuleiro.toList();
            GenerateAllLegalMoviments.gerarMovimentos(
                tmpTabuleiro, lastPiece, oldLocation, newLocation);
            if (is_xequed.getXequed(tabuleiro)?.pieceColor ==
                    piece.pieceColor ||
                is_xequed.getXequed(tmpTabuleiro)?.pieceColor ==
                    piece.pieceColor) piece.addIlegalMoviments(legalMoviment);

            piece.location = oldLocation;
            ult?.location = ultLocation!;
          }
        }
      }
    }

    GenerateAllLegalMoviments.gerarMovimentosNEW(
        tabuleiro, removeLocations, lastPiece, oldLocation, newLocation);
    for (ChessPiece piece in tabuleiro) {
      if (piece.ilegalMoviments != null) {
        for (Location location in piece.ilegalMoviments!) {
          removeIlegalMoviments.add(location);
        }
      }
    }

    limpailegalMoviments(tabuleiro, removeIlegalMoviments);
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

  static PieceColor? validateWinner(
      List<ChessPiece> tabuleiro, PieceColor color) {
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
        return null;
      } else {
        log("Pretas Win");
        return null;
      }
    }
    return null;
  }
}
