import 'dart:math';

import 'package:gpms/app/modules/game/domain/entities/chess/chess_match.dart';
import 'package:gpms/app/modules/game/domain/functions/find_piece.dart';
import '../entities/chess_piece_entity.dart';

bool moveTo(ChessMatch chessMatch, List<ChessPiece> boardPieces,
    ChessPiece piece, Location location) {
  var hasPiece = false;
  var hasAdPiece = false;
  ChessPiece? toKill;

  if (location.x < 1 || location.x > 8 || location.y < 0 || location.y > 7) {
    return false;
  }

  if (piece.name == 'king' &&
      !piece.moved &&
      ((location.x == 3 && location.y == 0) ||
          (location.x == 7 && location.y == 0) ||
          (location.x == 3 && location.y == 7) ||
          (location.x == 7 && location.y == 7))) {
    if (location.x == 3 && location.y == 0) {
      ChessPiece? rook = findPiece(boardPieces, Location(1, 0));
      if (rook != null) {
        rook.location.x = 4;
        rook.location.y = 0;
        rook.moved = true;
      } else {
        return false;
      }
    } else if (location.x == 7 && location.y == 0) {
      ChessPiece? rook = findPiece(boardPieces, Location(8, 0));
      if (rook != null) {
        rook.location.x = 6;
        rook.location.y = 0;
        rook.moved = true;
      } else {
        return false;
      }
    } else if (location.x == 3 && location.y == 7) {
      ChessPiece? rook = findPiece(boardPieces, Location(1, 7));
      if (rook != null) {
        rook.location.x = 4;
        rook.location.y = 7;
        rook.moved = true;
      } else {
        return false;
      }
    } else if (location.x == 7 && location.y == 7) {
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
    print("${toKill.pieceColor.name} ${toKill.name} captured");
    print(
        "${piece.pieceColor.name} ${piece.name} moved to x: ${piece.location.x} y: ${piece.location.y}");
    return true;
  } else if (hasPiece && !hasAdPiece) {
    return false;
  } else {
    piece.location.x = location.x;
    piece.location.y = location.y;
    piece.moved = true;
    print(
        "${piece.pieceColor.name} ${piece.name} moved to x: ${piece.location.x} y: ${piece.location.y}");
    return true;
  }
}
