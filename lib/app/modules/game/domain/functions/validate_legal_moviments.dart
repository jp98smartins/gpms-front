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
    if (lastPiece != null && oldLocation != null && newLocation != null) {
      log("Last piece moved: ${lastPiece.pieceColor.name} ${lastPiece.name} from (${oldLocation.x},${oldLocation.y}) to (${newLocation.x},${newLocation.y})");
    }
    List<Location> removeLocations = [Location(-1, -1)];
    GenerateAllLegalMoviments.gerarMovimentos(
        tabuleiro, lastPiece, oldLocation, newLocation);
    for (var piece in tabuleiro) {
      if (piece.legalMoviments != null) {
        List<Location> locationsForRemove = [];
        for (var legalMoviment in piece.legalMoviments!) {
          if (!Move.isLegalMovement(tabuleiro, piece, legalMoviment)) {
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
      if (piece.opMoviments != null) {
        List<Location> opLocationsForRemove = [];
        for (var opMoviment in piece.opMoviments!) {
          if (!Move.isLegalOpMovement(tabuleiro, piece, opMoviment)) {
            opLocationsForRemove.add(opMoviment);
          }
        }
        for (var olfr in opLocationsForRemove) {
          if (piece.opMoviments != null && piece.opMoviments!.contains(olfr)) {
            piece.remOpMoviments(olfr);
          }
        }
      }
    }
  }

  static void validateLegalMoviments_deprecated(List<ChessPiece> tabuleiro,
      [ChessPiece? lastPiece, Location? oldLocation, Location? newLocation]) {
    List<Location> removeIlegalMoviments = [Location(-1, -1)];
    List<Location> removeLocations = [Location(-1, -1)];
    GenerateAllLegalMoviments.gerarMovimentos(
        tabuleiro, lastPiece, oldLocation, newLocation);
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

    GenerateAllLegalMoviments.gerarMovimentos(
        tabuleiro, lastPiece, oldLocation, newLocation);
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

  static MatchResult? getMatchResult(
      List<ChessPiece> tabuleiro, ChessMatch chessMatch) {
    MatchResult? matchResult;
    ChessPiece? checkedKing = is_xequed.getXequed(tabuleiro);
    bool whiteHasValidMoves = false;
    bool blackHasValidMoves = false;
    int whitePiecesCount = 0;
    int blackPiecesCount = 0;

    for (ChessPiece cp in tabuleiro) {
      if (cp.pieceColor.name == 'white' && !cp.died) {
        whitePiecesCount++;
        if (cp.legalMoviments != null) {
          for (var legalMovement in cp.legalMoviments!) {
            whiteHasValidMoves = true;
          }
        }
      } else {
        blackPiecesCount++;
        if (cp.legalMoviments != null) {
          for (var legalMovement in cp.legalMoviments!) {
            blackHasValidMoves = true;
          }
        }
      }
    }

    if (checkedKing != null) {
      if (!blackHasValidMoves && chessMatch.pieceColor.name == 'black') {
        matchResult = MatchResult.white;
      }
      if (!whiteHasValidMoves && chessMatch.pieceColor.name == 'white') {
        matchResult = MatchResult.black;
      }
    } else {
      if (!blackHasValidMoves && chessMatch.pieceColor.name == 'black') {
        matchResult = MatchResult.draw;
      }
      if (!whiteHasValidMoves && chessMatch.pieceColor.name == 'white') {
        matchResult = MatchResult.draw;
      }
      if (whitePiecesCount < 2 && blackPiecesCount < 2) {
        matchResult = MatchResult.draw;
      }
      if (whitePiecesCount + blackPiecesCount < 4) {
        for (ChessPiece cp in tabuleiro) {
          if (cp.name == 'knight' || cp.name == 'bishop') {
            matchResult = MatchResult.draw;
          }
        }
      }
      if (whitePiecesCount + blackPiecesCount < 5) {
        int knights = 0;
        for (ChessPiece cp in tabuleiro) {
          if (cp.name == 'knight') {
            knights++;
          }
        }
        if (knights == 2) {
          matchResult = MatchResult.draw;
        }
      }
      if (whitePiecesCount == 2 && blackPiecesCount == 2) {
        int pieces = 0;
        for (ChessPiece cp in tabuleiro) {
          if (cp.name == 'knight' || cp.name == 'bishop') {
            pieces++;
          }
        }
        if (pieces == 2) {
          matchResult = MatchResult.draw;
        }
      }
    }

    if (matchResult != null) {
      log("Winner color: ${matchResult.name}");
    }

    return matchResult;
  }
}
