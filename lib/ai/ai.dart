import 'package:gpms/app/modules/game/domain/entities/chess/chess_match.dart';
import 'dart:math';
import 'package:meta/meta.dart';

import '../app/core/enums/game_difficulty.dart';
import '../app/modules/game/domain/entities/chess_piece_entity.dart';
import '../app/modules/game/domain/functions/find_piece.dart';
import '../app/modules/game/domain/functions/verify_moviment.dart';

class ChessAI {
  static void doMove(List<ChessPiece> tabuleiro, GameDifficulty? gameDifficulty,
      PieceColor pieceColor, ChessMatch chessMatch) {
    if (gameDifficulty != null) {
      switch (gameDifficulty) {
        case GameDifficulty.easy:
          easy(tabuleiro, gameDifficulty, pieceColor, chessMatch);
          break;
        case GameDifficulty.medium:
          medium(tabuleiro, gameDifficulty, pieceColor, chessMatch);
          break;
        case GameDifficulty.hard:
          hard(tabuleiro, gameDifficulty, pieceColor, chessMatch);
          break;
      }
    }
  }

  @protected
  static bool easy(List<ChessPiece> tabuleiro, GameDifficulty? gameDifficulty,
      PieceColor pieceColor, ChessMatch chessMatch) {
    tabuleiro.shuffle(Random(42));
    var moved = false;
    for (var onlyNotMoved in [true, false]) {
      for (var piece in tabuleiro) {
        if (piece.legalMoviments != null && pieceColor == piece.pieceColor) {
          for (var legalMoviment in piece.legalMoviments!) {
            var x = legalMoviment.x;
            var y = legalMoviment.y;
            if (x >= 0 &&
                y >= 0 &&
                ((onlyNotMoved && !piece.moved) || !onlyNotMoved)) {
              for (ChessPiece killed in tabuleiro) {
                if (killed.location.x == x &&
                    killed.location.y == y &&
                    killed != piece) {
                  killed.location = Location(-1, -1);
                  killed.died = true;
                  chessMatch.pecasMortas.add(killed);
                  break;
                }
              }
              piece.location.x = x;
              piece.location.y = y;
              piece.moved = true;
              moved = true;
              break;
            }
          }
        }
        if (moved) break;
      }
      if (moved) break;
    }
    return moved;
  }

  @protected
  static bool medium(List<ChessPiece> tabuleiro, GameDifficulty? gameDifficulty,
      PieceColor pieceColor, ChessMatch chessMatch) {
    bool moved = false;
    // Verifica se uma peca deve ser defendida
    ChessPiece? attackerToKill;
    List<ChessPiece> attackedList = [];
    for (var piece in tabuleiro) {
      if (piece.legalMoviments != null && pieceColor != piece.pieceColor) {
        for (var legalMoviment in piece.legalMoviments!) {
          var x = legalMoviment.x;
          var y = legalMoviment.y;
          if (x >= 0 && y >= 0) {
            for (ChessPiece killed in tabuleiro) {
              if (killed.location.x == x &&
                  killed.location.y == y &&
                  killed != piece) {
                if (killed.value >= piece.value) {
                  // Existe uma peca atacada de maior valor que o atacante
                  attackedList.add(killed);
                  attackerToKill = piece;
                }
              }
            }
          }
        }
      }
    }
    // Verifica se sobrou uma peca para ser defendida e escolhe a de maior valor
    ChessPiece? attackedToMove;
    bool fExec = false;
    for (ChessPiece attacked in attackedList) {
      if (fExec) {
        attackedToMove = attacked;
        fExec = false;
      } else {
        if (!(attackedToMove == null)) {
          attackedToMove =
              attacked.value > attackedToMove.value ? attacked : attackedToMove;
        }
      }
    }
    if (!(attackedToMove == null)) {
      // Verificar se é vantajoso eliminar o atacante
      for (var piece in tabuleiro) {
        if (piece.legalMoviments != null && pieceColor == piece.pieceColor) {
          for (var legalMoviment in piece.legalMoviments!) {
            var x = legalMoviment.x;
            var y = legalMoviment.y;
            if (x >= 0 && y >= 0) {
              if (!(attackerToKill != null)) {
                if (attackerToKill?.location.x == x &&
                    attackerToKill?.location.y == y &&
                    attackerToKill != piece) {
                  if (piece.value < attackedToMove.value) {
                    attackerToKill?.location = Location(-1, -1);
                    attackerToKill?.died = true;
                    chessMatch.pecasMortas.add(attackerToKill!);
                    piece.location.x = x;
                    piece.location.y = y;
                    piece.moved = true;
                    moved = true;
                    break;
                  }
                }
              }
            }
            if (moved) break;
          }
        }
        if (moved) break;
      }
      // Tenta mover a peca
      if (!moved) {
        if (!(attackedToMove.legalMoviments == null)) {
          for (var legalMoviment in attackedToMove.legalMoviments!) {
            var isSafe = true;
            for (var attacker in tabuleiro) {
              if (attacker.legalMoviments != null &&
                  pieceColor != attacker.pieceColor) {
                for (var attackerMoviment in attacker.legalMoviments!) {
                  var x = attackerMoviment.x;
                  var y = attackerMoviment.y;
                  if (x == legalMoviment.x && y == legalMoviment.y) {
                    isSafe = false;
                    break;
                  }
                }
              }
            }
            if (isSafe) {
              var x = legalMoviment.x;
              var y = legalMoviment.y;
              var hasToKill = false;
              for (ChessPiece killed in tabuleiro) {
                if (killed.location.x == x && killed.location.y == y) {
                  if (killed.value >= attackedToMove.value &&
                      killed != attackedToMove) {
                    hasToKill = true;
                    killed.location = Location(-1, -1);
                    killed.died = true;
                    chessMatch.pecasMortas.add(killed);
                    break;
                  }
                }
              }
              attackedToMove.location.x = x;
              attackedToMove.location.y = y;
              attackedToMove.moved = true;
              moved = true;
              break;
            }
            if (moved) break;
          }
        }
      }
    }

    // Verifica se tem uma captura vantajosa disponivel
    if (!moved) {
      for (var piece in tabuleiro) {
        if (piece.legalMoviments != null && pieceColor == piece.pieceColor) {
          for (var legalMoviment in piece.legalMoviments!) {
            var x = legalMoviment.x;
            var y = legalMoviment.y;
            if (x >= 0 && y >= 0) {
              for (ChessPiece killed in tabuleiro) {
                if (killed.location.x == x && killed.location.y == y) {
                  if (killed.value >= piece.value) {
                    killed.location = Location(-1, -1);
                    killed.died = true;
                    chessMatch.pecasMortas.add(killed);
                    piece.location.x = x;
                    piece.location.y = y;
                    piece.moved = true;
                    moved = true;
                    break;
                  }
                }
              }
              if (moved) break;
            }
          }
        }
        if (moved) break;
      }
    }

    // Verifica se tem uma captura igual
    if (!moved) {
      for (var piece in tabuleiro) {
        if (piece.legalMoviments != null && pieceColor == piece.pieceColor) {
          for (var legalMoviment in piece.legalMoviments!) {
            var x = legalMoviment.x;
            var y = legalMoviment.y;
            if (x >= 0 && y >= 0) {
              for (ChessPiece killed in tabuleiro) {
                if (killed.location.x == x && killed.location.y == y) {
                  if (killed.value == piece.value) {
                    killed.location = Location(-1, -1);
                    killed.died = true;
                    chessMatch.pecasMortas.add(killed);
                    piece.location.x = x;
                    piece.location.y = y;
                    piece.moved = true;
                    moved = true;
                    break;
                  }
                }
              }
              if (moved) break;
            }
          }
        }
        if (moved) break;
      }
    }
    if (!moved) {
      moved = easy(tabuleiro, gameDifficulty, pieceColor, chessMatch);
    }
    return moved;
  }

  @protected
  static bool hard(List<ChessPiece> tabuleiro, GameDifficulty? gameDifficulty,
      PieceColor pieceColor, ChessMatch chessMatch) {
    bool moved = false;
    if (!moved) {
      moved = medium(tabuleiro, gameDifficulty, pieceColor, chessMatch);
    }
    if (!moved) {
      moved = easy(tabuleiro, gameDifficulty, pieceColor, chessMatch);
    }
    return moved;
  }
}
