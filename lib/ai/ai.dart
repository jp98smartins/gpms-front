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
    tabuleiro.shuffle(Random());
    var moved = false;
    for (var onlyNotMoved in [true, false]) {
      for (var piece in tabuleiro) {
        if (!(piece.legalMoviments == null) && pieceColor == piece.pieceColor) {
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
    List<ChessPiece> attackedList = [];
    List<ChessPiece> attackerList = [];
    for (var piece in tabuleiro) {
      if (piece.legalMoviments != null && pieceColor != piece.pieceColor) {
        // Apenas pecas de cor oposta
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
                  attackerList.add(piece);
                }
              }
            }
          }
        }
      }
    }
    // Verifica se sobrou uma peca para ser defendida e escolhe a de maior valor
    ChessPiece? attackerToKill;
    ChessPiece? attackedToMove;
    bool fExec = false;
    for (var i = 0; i < attackedList.length; i++) {
      if (fExec) {
        attackedToMove = attackedList[i];
        attackerToKill = attackerList[i];
        fExec = false;
      } else {
        if (!(attackedToMove == null)) {
          attackedToMove = attackedList[i].value > attackedToMove.value
              ? attackedList[i]
              : attackedToMove;
          attackerToKill = attackedList[i].value > attackedToMove.value
              ? attackerList[i]
              : attackerToKill;
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
              if (!(attackerToKill == null)) {
                if (attackerToKill.location.x == x &&
                    attackerToKill.location.y == y &&
                    attackerToKill != piece) {
                  if (piece.value <= attackerToKill.value) {
                    attackerToKill.location = Location(-1, -1);
                    attackerToKill.died = true;
                    chessMatch.pecasMortas.add(attackerToKill);
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
      if (!moved) {
        // Verificar se é vantajoso eliminar o atacante com uma peca de menor valor que a peca atacada
        for (var piece in tabuleiro) {
          if (piece.legalMoviments != null && pieceColor == piece.pieceColor) {
            for (var legalMoviment in piece.legalMoviments!) {
              var x = legalMoviment.x;
              var y = legalMoviment.y;
              if (x >= 0 && y >= 0) {
                if (!(attackerToKill == null)) {
                  if (attackerToKill.location.x == x &&
                      attackerToKill.location.y == y &&
                      attackerToKill != piece) {
                    if (piece.value < attackedToMove.value) {
                      attackerToKill.location = Location(-1, -1);
                      attackerToKill.died = true;
                      chessMatch.pecasMortas.add(attackerToKill);
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
    List<ChessPiece> myAttackedList = [];
    List<ChessPiece> attackerListForMy = [];
    List<ChessPiece> adAttackedList = [];
    List<ChessPiece> attackerListForAd = [];
    List<ChessPiece> myNotDefendedAttackedList = [];
    List<ChessPiece> attackerListForMyNotDefended = [];
    List<ChessPiece> adNotDefendedAttackedList = [];
    List<ChessPiece> attackerListForAdNotDefended = [];
    // Define as pecas atacadas do jogador
    for (var piece in tabuleiro) {
      if (piece.legalMoviments != null && pieceColor != piece.pieceColor) {
        // Apenas pecas de cor oposta
        for (var legalMoviment in piece.legalMoviments!) {
          var x = legalMoviment.x;
          var y = legalMoviment.y;
          if (x >= 0 && y >= 0) {
            for (ChessPiece killed in tabuleiro) {
              if (killed.location.x == x && killed.location.y == y) {
                myAttackedList.add(killed);
                attackerListForMy.add(piece);
              }
            }
          }
        }
      }
    }
    // Define as pecas atacadas do adversario
    for (var piece in tabuleiro) {
      if (piece.legalMoviments != null && pieceColor == piece.pieceColor) {
        // Apenas pecas da mesma cor
        for (var legalMoviment in piece.legalMoviments!) {
          var x = legalMoviment.x;
          var y = legalMoviment.y;
          if (x >= 0 && y >= 0) {
            for (ChessPiece killed in tabuleiro) {
              if (killed.location.x == x && killed.location.y == y) {
                adAttackedList.add(killed);
                attackerListForAd.add(piece);
              }
            }
          }
        }
      }
    }
    // Define as pecas atacadas e nao defendidas do jogador
    if (myAttackedList.isNotEmpty) {
      for (ChessPiece attacked in myAttackedList) {
        bool defended = false;
        for (var piece in tabuleiro) {
          if (piece.legalMoviments != null &&
              attacked.pieceColor != piece.pieceColor) {
            for (var legalMoviment in piece.legalMoviments!) {
              var x = legalMoviment.x;
              var y = legalMoviment.y;
              if (x >= 0 &&
                  y >= 0 &&
                  attacked.location.x == x &&
                  attacked.location.y == y &&
                  attacked != piece) {
                defended = true;
                break;
              }
            }
          }
        }
        if (!defended) {
          myNotDefendedAttackedList.add(attacked);
          ChessPiece? attacker =
              attackerListForMy[myAttackedList.indexOf(attacked)];
          attackerListForMyNotDefended.add(attacker);
        }
      }
    }
    // Define as pecas atacadas e nao defendidas do adversario
    if (adAttackedList.isNotEmpty) {
      for (ChessPiece attacked in adAttackedList) {
        bool defended = false;
        for (var piece in tabuleiro) {
          if (piece.legalMoviments != null &&
              attacked.pieceColor != piece.pieceColor) {
            for (var legalMoviment in piece.legalMoviments!) {
              var x = legalMoviment.x;
              var y = legalMoviment.y;
              if (x >= 0 &&
                  y >= 0 &&
                  attacked.location.x == x &&
                  attacked.location.y == y &&
                  attacked != piece) {
                defended = true;
                break;
              }
            }
          }
        }
        if (!defended) {
          adNotDefendedAttackedList.add(attacked);
          ChessPiece? attacker =
              attackerListForAd[adAttackedList.indexOf(attacked)];
          attackerListForAdNotDefended.add(attacker);
        }
      }
    }

    // Verifica se e vantajoso atacar uma peca ou defender uma peca
    bool fExec = true;
    int? bestCaseMy;
    ChessPiece? bestCaseMyAttacked;
    ChessPiece? bestCaseMyAttacker;
    int? bestCaseAd;
    ChessPiece? bestCaseAdAttacked;
    ChessPiece? bestCaseAdAttacker;

    for (var i = 0; i < adAttackedList.length; i++) {
      int value;
      int indexNotDefended =
          adNotDefendedAttackedList.indexOf(adAttackedList[i]);

      if (indexNotDefended == -1) {
        value = adAttackedList[i].value;
      } else {
        print(
            "${adAttackedList[i]} ${adAttackedList[i].pieceColor.name} esta protegida");
        value = adAttackedList[i].value - attackerListForAd[i].value;
      }

      if (fExec) {
        bestCaseMy = value;
        bestCaseMyAttacked = adAttackedList[i];
        bestCaseMyAttacker = attackerListForAd[i];
      }
      if (value > bestCaseMy) {
        bestCaseMy = value;
        bestCaseMyAttacked = adAttackedList[i];
        bestCaseMyAttacker = attackerListForAd[i];
      }
    }

    fExec = true;
    for (var i = 0; i < myAttackedList.length; i++) {
      int value;
      int indexNotDefended =
          myNotDefendedAttackedList.indexOf(myAttackedList[i]);

      if (indexNotDefended == -1) {
        value = myAttackedList[i].value;
      } else {
        print(
            "${myAttackedList[i]} ${myAttackedList[i].pieceColor.name} esta protegida");
        value = myAttackedList[i].value - attackerListForMy[i].value;
      }

      if (fExec) {
        bestCaseAd = value;
        bestCaseAdAttacked = myAttackedList[i];
        bestCaseAdAttacker = attackerListForMy[i];
      }
      if (value > bestCaseAd) {
        bestCaseAd = value;
        bestCaseAdAttacked = myAttackedList[i];
        bestCaseAdAttacker = attackerListForMy[i];
      }
    }

    bool defense = false;
    bool capture = false;

    print("| bestCaseMy: $bestCaseMy | bestCaseAd: $bestCaseAd |");

    if (!(bestCaseMy == null) && !(bestCaseAd == null)) {
      if (bestCaseMy >= bestCaseAd && bestCaseMy > 0) {
        capture = true;
      } else {
        defense = true;
      }
    } else if (!(bestCaseMy == null)) {
      if (bestCaseMy > 0) {
        capture = true;
      } else {
        defense = true;
      }
    } else if (!(bestCaseAd == null)) {
      if (bestCaseAd > 0) {
        defense = true;
      }
    }

    if (capture) {
      var x = bestCaseMyAttacked!.location.x;
      var y = bestCaseMyAttacked.location.y;
      bestCaseMyAttacked.location = Location(-1, -1);
      bestCaseMyAttacked.died = true;
      chessMatch.pecasMortas.add(bestCaseMyAttacked);
      bestCaseMyAttacker!.location.x = x;
      bestCaseMyAttacker.location.y = y;
      bestCaseMyAttacker.moved = true;
      moved = true;
    } else if (defense) {
      if (!(bestCaseAdAttacker == null)) {
// Verifica se o atacante nao esta defendido e esta atacado
        if (adNotDefendedAttackedList.contains(bestCaseAdAttacker)) {
          int index = adNotDefendedAttackedList.indexOf(bestCaseAdAttacker);
          ChessPiece myAttacker = attackerListForAdNotDefended[index];
          var x = bestCaseAdAttacker.location.x;
          var y = bestCaseAdAttacker.location.y;
          bestCaseAdAttacker.location = Location(-1, -1);
          bestCaseAdAttacker.died = true;
          chessMatch.pecasMortas.add(bestCaseAdAttacker);
          myAttacker.location.x = x;
          myAttacker.location.y = y;
          myAttacker.moved = true;
          moved = true;
        }
        // Verifica se o atacante esta atacado por uma peca de menor valor
        // que a a peca atacante
        if (!moved) {
          if (adAttackedList.contains(bestCaseAdAttacker)) {
            int index = adAttackedList.indexOf(bestCaseAdAttacker);
            ChessPiece myAttacker = attackerListForAd[index];
            if (myAttacker.value <= bestCaseAdAttacker.value) {
              ChessPiece myAttacker = attackerListForAdNotDefended[index];
              var x = bestCaseAdAttacker.location.x;
              var y = bestCaseAdAttacker.location.y;
              bestCaseAdAttacker.location = Location(-1, -1);
              bestCaseAdAttacker.died = true;
              chessMatch.pecasMortas.add(bestCaseAdAttacker);
              myAttacker.location.x = x;
              myAttacker.location.y = y;
              myAttacker.moved = true;
              moved = true;
            }
          }
        }
        // Verifica se o atacante esta atacado por uma peca de menor valor
        // que a a peca atacada
        if (!moved) {
          if (adAttackedList.contains(bestCaseAdAttacker)) {
            int index = adAttackedList.indexOf(bestCaseAdAttacker);
            ChessPiece myAttacker = attackerListForAd[index];
            if (myAttacker.value <= bestCaseAdAttacked!.value) {
              ChessPiece myAttacker = attackerListForAdNotDefended[index];
              var x = bestCaseAdAttacker.location.x;
              var y = bestCaseAdAttacker.location.y;
              bestCaseAdAttacker.location = Location(-1, -1);
              bestCaseAdAttacker.died = true;
              chessMatch.pecasMortas.add(bestCaseAdAttacker);
              myAttacker.location.x = x;
              myAttacker.location.y = y;
              myAttacker.moved = true;
              moved = true;
            }
          }
        }
      }
      // Tenta mover a peca para uma posicao nao atacada
      if (!moved) {
        if (bestCaseAdAttacked!.legalMoviments != null &&
            bestCaseAdAttacked.name != 'king') {
          for (var attackedLegalMoviment
              in bestCaseAdAttacked.legalMoviments!) {
            if (!(findPiece(tabuleiro, attackedLegalMoviment) == null)) {
              continue;
            }
            bool validLocation = true;
            for (var piece in tabuleiro) {
              if (piece.legalMoviments != null &&
                  pieceColor != piece.pieceColor) {
                for (var legalMoviment in piece.legalMoviments!) {
                  if (legalMoviment.x == attackedLegalMoviment.x &&
                      legalMoviment.y == attackedLegalMoviment.y &&
                      attackedLegalMoviment.x >= 0 &&
                      attackedLegalMoviment.y >= 0) {
                    validLocation = false;
                    break;
                  }
                }
              }
            }
            if (validLocation) {
              bestCaseAdAttacked.location.x = attackedLegalMoviment.x;
              bestCaseAdAttacked.location.y = attackedLegalMoviment.y;
              bestCaseAdAttacked.moved = true;
              moved = true;
              break;
            }
          }
        }
      }
      // Tenta mover a peca para uma posicao atacada porem defendida
      if (!moved) {
        if (bestCaseAdAttacked!.legalMoviments != null &&
            bestCaseAdAttacked.name != 'king') {
          for (var attackedLegalMoviment
              in bestCaseAdAttacked.legalMoviments!) {
            if (!(findPiece(tabuleiro, attackedLegalMoviment) == null)) {
              continue;
            }
            bool validLocation = false;
            for (var piece in tabuleiro) {
              if (piece.legalMoviments != null &&
                  pieceColor == piece.pieceColor) {
                for (var legalMoviment in piece.legalMoviments!) {
                  if (legalMoviment.x == attackedLegalMoviment.x &&
                      legalMoviment.y == attackedLegalMoviment.y &&
                      attackedLegalMoviment.x >= 0 &&
                      attackedLegalMoviment.y >= 0) {
                    validLocation = true;
                    break;
                  }
                }
              }
            }
            if (validLocation) {
              bestCaseAdAttacked.location.x = attackedLegalMoviment.x;
              bestCaseAdAttacked.location.y = attackedLegalMoviment.y;
              bestCaseAdAttacked.moved = true;
              moved = true;
              break;
            }
          }
        }
      }
    }

    if (!moved) {
      moved = medium(tabuleiro, gameDifficulty, pieceColor, chessMatch);
    }

    if (!moved) {
      moved = easy(tabuleiro, gameDifficulty, pieceColor, chessMatch);
    }
    return moved;
  }
}
