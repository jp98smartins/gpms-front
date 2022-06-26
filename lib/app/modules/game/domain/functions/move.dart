import 'dart:math';

import 'package:gpms/app/modules/game/domain/entities/chess/chess_match.dart';
import 'package:gpms/app/modules/game/domain/functions/find_piece.dart';
import 'package:gpms/app/modules/game/domain/functions/is_xequed.dart';
import '../entities/chess_piece_entity.dart';
import '../entities/bishop_entity.dart';
import '../entities/chess_piece_entity.dart';
import '../entities/king_entity.dart';
import '../entities/knight_entity.dart';
import '../entities/pawn_entity.dart';
import '../entities/queen_entity.dart';
import '../entities/rook_entity.dart';

import 'generate_all_legal_moviments.dart';

class Move {
  static bool moveTo(ChessMatch chessMatch, List<ChessPiece> boardPieces,
      ChessPiece piece, Location location) {
    var hasPiece = false;
    var hasAdPiece = false;
    ChessPiece? toKill;

    if (location.x < 1 || location.x > 8 || location.y < 0 || location.y > 7) {
      return false;
    }

    if (piece.name == 'pawn' &&
        piece.location.x != location.x &&
        findPiece(boardPieces, Location(location.x, location.y)) == null) {
      ChessPiece? toKill = findPiece(
          boardPieces,
          Location(
              location.x,
              piece.pieceColor.name == 'white'
                  ? location.y + 1
                  : location.y - 1));
      if (toKill != null) {
        toKill.location = Location(-1, -1);
        toKill.died = true;
        chessMatch.addPecasMortas(toKill);
        piece.location.x = location.x;
        piece.location.y = location.y;
        piece.moved = true;
        return true;
      } else {
        return false;
      }
    }

    if (piece.name == 'king' &&
        !piece.moved &&
        ((location.x == 3 && location.y == 0) ||
            (location.x == 7 && location.y == 0) ||
            (location.x == 3 && location.y == 7) ||
            (location.x == 7 && location.y == 7))) {
      if (location.x == 3 && location.y == 0) {
        if (isCheckedOn(boardPieces, piece, Location(2, 0)) ||
            isCheckedOn(boardPieces, piece, Location(3, 0))) {
          return false;
        }
        ChessPiece? rook = findPiece(boardPieces, Location(1, 0));
        if (rook != null) {
          rook.location.x = 4;
          rook.location.y = 0;
          rook.moved = true;
        } else {
          return false;
        }
      } else if (location.x == 7 && location.y == 0) {
        if (isCheckedOn(boardPieces, piece, Location(6, 0)) ||
            isCheckedOn(boardPieces, piece, Location(7, 0))) {
          return false;
        }
        ChessPiece? rook = findPiece(boardPieces, Location(8, 0));
        if (rook != null) {
          rook.location.x = 6;
          rook.location.y = 0;
          rook.moved = true;
        } else {
          return false;
        }
      } else if (location.x == 3 && location.y == 7) {
        if (isCheckedOn(boardPieces, piece, Location(2, 7)) ||
            isCheckedOn(boardPieces, piece, Location(3, 7))) {
          return false;
        }
        ChessPiece? rook = findPiece(boardPieces, Location(1, 7));
        if (rook != null) {
          rook.location.x = 4;
          rook.location.y = 7;
          rook.moved = true;
        } else {
          return false;
        }
      } else if (location.x == 7 && location.y == 7) {
        if (isCheckedOn(boardPieces, piece, Location(6, 7)) ||
            isCheckedOn(boardPieces, piece, Location(7, 7))) {
          return false;
        }
        ChessPiece? rook = findPiece(boardPieces, Location(8, 7));
        if (rook != null) {
          rook.location.x = 6;
          rook.location.y = 7;
          rook.moved = true;
        } else {
          return false;
        }
      }
      piece.location.x = location.x;
      piece.location.y = location.y;
      piece.moved = true;
      return true;
    }

    for (ChessPiece p in boardPieces) {
      if (p.location.x == location.x && p.location.y == location.y) {
        hasPiece = true;
        if (p.pieceColor != piece.pieceColor) {
          hasAdPiece = true;
          toKill = p;
        }
        break;
      }
    }

    var isValidLocationForPiece = false;
    if (piece.legalMoviments != null) {
      for (Location lm in piece.legalMoviments!) {
        if (lm.x == location.x && lm.y == location.y) {
          isValidLocationForPiece = true;
        }
      }
    }
    if (!isValidLocationForPiece) {
      return false;
    }

    if (hasAdPiece && toKill != null) {
      toKill.location = Location(-1, -1);
      toKill.died = true;
      chessMatch.addPecasMortas(toKill);
      piece.location.x = location.x;
      piece.location.y = location.y;
      piece.moved = true;
      return true;
    } else if (hasPiece && !hasAdPiece) {
      return false;
    } else {
      piece.location.x = location.x;
      piece.location.y = location.y;
      piece.moved = true;
      return true;
    }
  }

  static bool isCheckedOn(
      List<ChessPiece> boardPieces, ChessPiece king, Location location) {
    if (king.name != 'king' ||
        location.x < 1 ||
        location.x > 8 ||
        location.y < 0 ||
        location.y > 7) return false;

    Location oldLocation = Location(king.location.x, king.location.y);
    ChessPiece? captured = findPiece(boardPieces, location);
    if (captured != null && captured.pieceColor.name == king.pieceColor.name) {
      return false;
    }

    Location capturedOldLocation = Location(-1, -1);
    if (captured != null) {
      capturedOldLocation = Location(captured.location.x, captured.location.y);
      captured.location.x = -1;
      captured.location.y = -1;
      captured.died = true;
    }

    king.location.x = location.x;
    king.location.y = location.y;

    bool checked = false;
    for (ChessPiece p in boardPieces) {
      if (p.opMoviments != null && p.pieceColor.name != king.pieceColor.name) {
        for (Location om in p.opMoviments!) {
          if (om.x == location.x && om.y == location.y) {
            checked = true;
            break;
          }
        }
        if (checked) {
          print(
              "(${location.x},${location.y}) not is a valid position for king");
          break;
        }
      }
    }

    if (captured != null) {
      captured.location.x = capturedOldLocation.x;
      captured.location.y = capturedOldLocation.y;
      captured.died = false;
    }

    king.location.x = oldLocation.x;
    king.location.y = oldLocation.y;

    return checked;
  }

  static bool isLegalMovement(
      List<ChessPiece> boardPieces, ChessPiece piece, Location location) {
    List<ChessPiece> boardPiecesCopy = deepCopyFromChessBoard(boardPieces);
    Location pieceOldLocation = Location(piece.location.x, piece.location.y);
    Location capturedOldLocation = Location(-1, -1);
    ChessPiece? captured = findPiece(boardPiecesCopy, location);

    if (location.x < 1 || location.x > 8 || location.y < 0 || location.y > 7) {
      return false;
    }

    if (captured != null && captured.pieceColor.name == piece.pieceColor.name) {
      return false;
    }

    if (captured != null) {
      capturedOldLocation = Location(captured.location.x, captured.location.y);
      captured.location.x = -1;
      captured.location.y = -1;
      captured.died = true;
    }

    bool isValid = true;
    if (piece.name == 'king' &&
        !piece.moved &&
        ((location.x == 3 && location.y == 0) ||
            (location.x == 7 && location.y == 0) ||
            (location.x == 3 && location.y == 7) ||
            (location.x == 7 && location.y == 7))) {
      if (location.x == 3 && location.y == 0) {
        ChessPiece? rook = findPiece(boardPiecesCopy, Location(1, 0));

        if (isCheckedOn(boardPiecesCopy, piece, Location(2, 0)) ||
            isCheckedOn(boardPiecesCopy, piece, Location(3, 0))) {
          isValid = false;
        }

        if (rook != null && rook.moved) {
          isValid = false;
        }
      } else if (location.x == 7 && location.y == 0) {
        ChessPiece? rook = findPiece(boardPiecesCopy, Location(8, 0));

        if (isCheckedOn(boardPiecesCopy, piece, Location(6, 0)) ||
            isCheckedOn(boardPiecesCopy, piece, Location(7, 0))) {
          isValid = false;
        }

        if (rook != null && rook.moved) {
          isValid = false;
        }
      } else if (location.x == 3 && location.y == 7) {
        ChessPiece? rook = findPiece(boardPiecesCopy, Location(1, 7));

        if (isCheckedOn(boardPiecesCopy, piece, Location(2, 7)) ||
            isCheckedOn(boardPiecesCopy, piece, Location(3, 7))) {
          isValid = false;
        }

        if (rook != null && rook.moved) {
          isValid = false;
        }
      } else if (location.x == 7 && location.y == 7) {
        ChessPiece? rook = findPiece(boardPiecesCopy, Location(8, 7));

        if (isCheckedOn(boardPiecesCopy, piece, Location(6, 7)) ||
            isCheckedOn(boardPiecesCopy, piece, Location(7, 7))) {
          isValid = false;
        }

        if (rook != null && rook.moved) {
          isValid = false;
        }
      }
    }

    piece.location.x = location.x;
    piece.location.y = location.y;

    GenerateAllLegalMoviments.gerarMovimentosNEW(
        boardPiecesCopy, [], piece, pieceOldLocation, location);
    ChessPiece? checkedKing = is_xequed.getXequed(boardPiecesCopy);
    if (checkedKing != null &&
        checkedKing.pieceColor.name == piece.pieceColor.name) {
      isValid = false;
    }

    if (captured != null) {
      captured.location.x = capturedOldLocation.x;
      captured.location.y = capturedOldLocation.y;
      captured.died = false;
    }

    piece.location.x = pieceOldLocation.x;
    piece.location.y = pieceOldLocation.y;

    if (piece.name == 'king') {
      print(
          "(${piece.location.x}, ${piece.location.y}) is valid for ${piece.pieceColor.name} king");
    }

    return isValid;
  }

  static List<ChessPiece> deepCopyFromChessBoard(List<ChessPiece> chessPieces) {
    List<ChessPiece> copy = <ChessPiece>[];
    for (ChessPiece p in chessPieces) {
      bool died = p.died;
      bool moved = p.moved;
      String name = p.name;
      PieceColor pieceColor =
          p.pieceColor.name == 'white' ? PieceColor.white : PieceColor.black;
      Location location = Location(p.location.x, p.location.y);

      ChessPiece? chessPiece;
      switch (name) {
        case "pawn":
          chessPiece = Pawn(pieceColor, location);
          break;
        case "rook":
          chessPiece = Rook(pieceColor, location);
          break;
        case "bishop":
          chessPiece = Bishop(pieceColor, location);
          break;
        case "knight":
          chessPiece = Knight(pieceColor, location);
          break;
        case "queen":
          chessPiece = Queen(pieceColor, location);
          break;
        case "king":
          chessPiece = King(pieceColor, location);
          break;
      }

      if (chessPiece != null) {
        chessPiece.died = died;
        chessPiece.moved = moved;

        if (p.legalMoviments != null) {
          p.legalMoviments!.forEach((lm) {
            Location lmc = Location(lm.x, lm.y);
            chessPiece!.addLegalMoviments(lmc);
          });
        }

        if (p.ilegalMoviments != null) {
          p.ilegalMoviments!.forEach((im) {
            Location imc = Location(im.x, im.y);
            chessPiece!.addLegalMoviments(imc);
          });
        }

        if (p.opMoviments != null) {
          p.opMoviments!.forEach((o) {
            Location oc = Location(o.x, o.y);
            chessPiece!.addLegalMoviments(oc);
          });
        }

        copy.add(chessPiece);
      }
    }

    return copy;
  }
}
