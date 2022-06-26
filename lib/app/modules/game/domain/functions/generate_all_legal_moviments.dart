import 'dart:developer';

import '../entities/chess_piece_entity.dart';
import 'find_piece.dart';
import 'is_xequed.dart';

class GenerateAllLegalMoviments {
  //RECEBE O TABULEIRO E GERA TODOS OS MOVIEMTOS DE CADA PEÇA, SEM VALIDAÇÕES DE XEQUE
  static void gerarMovimentos(List<ChessPiece> tabuleiro,
      [ChessPiece? lastPiece,
      Location? oldLocation,
      Location? newLocation]) async {
    //removeLegalMoviments(tabuleiro);
    for (var element in tabuleiro) {
      int x = element.location.x;
      int y = element.location.y;
      element.legalMoviments = null;
      element.opMoviments = null;
      int verificaPosX = 0;
      int verificaPosY = 0;
      switch (element.name) {
        case 'bishop':
          verificaPosX = x;
          verificaPosY = y;

          verificaPosX--;
          verificaPosY--;

          //VERIFICA SETOR NEGATIVO X E SETOR NEGATIVO Y
          while (verificaPosX >= 1 && verificaPosY >= 0) {
            element.addOpMoviments(Location(verificaPosX, verificaPosY));
            var possivelPeca =
                findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
            if (possivelPeca == null) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              break;
            } else {
              break;
            }
            verificaPosX--;
            verificaPosY--;
          }

          //VERIFICA SETOR NEGATIVO X E SETOR POSITIVO Y
          verificaPosX = x;
          verificaPosY = y;

          verificaPosX--;
          verificaPosY++;

          while (verificaPosX >= 1 && verificaPosY <= 7) {
            element.addOpMoviments(Location(verificaPosX, verificaPosY));
            var possivelPeca =
                findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
            if (possivelPeca == null) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              break;
            } else {
              break;
            }
            verificaPosX--;
            verificaPosY++;
          }

          //VERIFICA SETOR POSITIVO X E SETOR NEGATIVO Y
          verificaPosX = x;
          verificaPosY = y;

          verificaPosX++;
          verificaPosY--;

          while (verificaPosX <= 8 && verificaPosY >= 0) {
            element.addOpMoviments(Location(verificaPosX, verificaPosY));
            var possivelPeca =
                findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
            if (possivelPeca == null) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              break;
            } else {
              break;
            }
            verificaPosX++;
            verificaPosY--;
          }

          //VERIFICA SETOR POSITIVO X E SETOR POSITIVO Y
          verificaPosX = x;
          verificaPosY = y;

          verificaPosX++;
          verificaPosY++;

          while (verificaPosX <= 8 && verificaPosY <= 7) {
            element.addOpMoviments(Location(verificaPosX, verificaPosY));
            var possivelPeca =
                findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
            if (possivelPeca == null) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              break;
            } else {
              break;
            }
            verificaPosX++;
            verificaPosY++;
          }

          break;

        case 'knight':
          void verificaAddPosicaoCavalo(int verificaPosX, int verificaPosY) {
            var possivelPeca =
                findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
            element.addOpMoviments(Location(verificaPosX, verificaPosY));
            if (possivelPeca == null ||
                possivelPeca.pieceColor != element.pieceColor) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
            }
          }
          verificaPosX = x;
          verificaPosY = y;

          verificaPosY += 2;
          verificaPosX += 1;
          verificaAddPosicaoCavalo(verificaPosX, verificaPosY);

          verificaPosX -= 2;
          verificaAddPosicaoCavalo(verificaPosX, verificaPosY);

          verificaPosX = x;
          verificaPosY = y;

          verificaPosY -= 2;
          verificaPosX += 1;
          verificaAddPosicaoCavalo(verificaPosX, verificaPosY);

          verificaPosX -= 2;
          verificaAddPosicaoCavalo(verificaPosX, verificaPosY);

          verificaPosX = x;
          verificaPosY = y;

          verificaPosX += 2;
          verificaPosY += 1;
          verificaAddPosicaoCavalo(verificaPosX, verificaPosY);

          verificaPosY -= 2;
          verificaAddPosicaoCavalo(verificaPosX, verificaPosY);

          verificaPosX = x;
          verificaPosY = y;

          verificaPosX -= 2;
          verificaPosY += 1;
          verificaAddPosicaoCavalo(verificaPosX, verificaPosY);

          verificaPosY -= 2;
          verificaAddPosicaoCavalo(verificaPosX, verificaPosY);

          break;

        case 'pawn':
          verificaPosX = x;
          verificaPosY = y;
          var blockingPiece = false;
          if (element.pieceColor == PieceColor.black) {
            verificaPosY++;
          } else {
            verificaPosY--;
          }
          var possivelPeca =
              findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
          if (possivelPeca == null) {
            element.addLegalMoviments(Location(verificaPosX, verificaPosY));
          } else {
            blockingPiece = true;
          }
          verificaPosX--;
          possivelPeca =
              findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
          element.addOpMoviments(Location(verificaPosX, verificaPosY));
          if (possivelPeca != null &&
              possivelPeca.pieceColor != element.pieceColor) {
            element.addLegalMoviments(Location(verificaPosX, verificaPosY));
          }
          verificaPosX += 2;
          possivelPeca =
              findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
          element.addOpMoviments(Location(verificaPosX, verificaPosY));
          if (possivelPeca != null &&
              possivelPeca.pieceColor != element.pieceColor) {
            element.addLegalMoviments(Location(verificaPosX, verificaPosY));
          }

          //En passant
          if ((element.pieceColor.name == 'white' && y == 3) ||
              (element.pieceColor.name == 'black' && y == 4)) {
            if (lastPiece != null &&
                oldLocation != null &&
                newLocation != null) {
              if (element.pieceColor.name == 'white' &&
                  oldLocation.y == 1 &&
                  newLocation.y == 3 &&
                  lastPiece.name == 'pawn') {
                if (oldLocation.x == x + 1 || oldLocation.x == x - 1) {
                  element.addLegalMoviments(Location(oldLocation.x, 2));
                  element.addOpMoviments(Location(oldLocation.x, 2));
                }
              }
              if (element.pieceColor.name == 'black' &&
                  oldLocation.y == 6 &&
                  newLocation.y == 4 &&
                  lastPiece.name == 'pawn') {
                if (oldLocation.x == x + 1 || oldLocation.x == x - 1) {
                  element.addLegalMoviments(Location(oldLocation.x, 5));
                  element.addOpMoviments(Location(oldLocation.x, 5));
                }
              }
            }
          }

          if (element.moved == false && !blockingPiece) {
            verificaPosX = x;
            verificaPosY = y;
            if (element.pieceColor == PieceColor.black) {
              verificaPosY += 2;
            } else {
              verificaPosY -= 2;
            }
            var possivelPeca =
                findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
            if (possivelPeca == null) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
            }
          }
          break;

        case 'queen':
          verificaPosX = x;
          verificaPosY = y;
          verificaPosX--;
          verificaPosY--;

          //VERIFICA SETOR NEGATIVO X E SETOR NEGATIVO Y
          while (verificaPosX >= 1 && verificaPosY >= 0) {
            var possivelPeca =
                findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
            element.addOpMoviments(Location(verificaPosX, verificaPosY));
            if (possivelPeca == null) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              break;
            } else {
              break;
            }
            verificaPosX--;
            verificaPosY--;
          }

          //VERIFICA SETOR NEGATIVO X E SETOR POSITIVO Y
          verificaPosX = x;
          verificaPosY = y;

          verificaPosX--;
          verificaPosY++;

          while (verificaPosX >= 1 && verificaPosY <= 7) {
            var possivelPeca =
                findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
            element.addOpMoviments(Location(verificaPosX, verificaPosY));
            if (possivelPeca == null) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              break;
            } else {
              break;
            }
            verificaPosX--;
            verificaPosY++;
          }

          //VERIFICA SETOR POSITIVO X E SETOR NEGATIVO Y
          verificaPosX = x;
          verificaPosY = y;

          verificaPosX++;
          verificaPosY--;

          while (verificaPosX <= 8 && verificaPosY >= 0) {
            var possivelPeca =
                findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
            element.addOpMoviments(Location(verificaPosX, verificaPosY));
            if (possivelPeca == null) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              break;
            } else {
              break;
            }
            verificaPosX++;
            verificaPosY--;
          }

          //VERIFICA SETOR POSITIVO X E SETOR POSITIVO Y
          verificaPosX = x;
          verificaPosY = y;

          verificaPosX++;
          verificaPosY++;

          while (verificaPosX <= 8 && verificaPosY <= 7) {
            var possivelPeca =
                findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
            element.addOpMoviments(Location(verificaPosX, verificaPosY));
            if (possivelPeca == null) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              break;
            } else {
              break;
            }
            verificaPosX++;
            verificaPosY++;
          }

          verificaPosX = x;
          verificaPosY = y;

          verificaPosX--;

          //VERIFICA SETOR NEGATIVO X
          while (verificaPosX >= 1) {
            var possivelPeca =
                findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
            element.addOpMoviments(Location(verificaPosX, verificaPosY));
            if (possivelPeca == null) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              break;
            } else {
              break;
            }
            verificaPosX--;
          }

          //VERIFICA SETOR POSITIVO X
          verificaPosX = x;
          verificaPosY = y;

          verificaPosX++;

          while (verificaPosX <= 8) {
            var possivelPeca =
                findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
            element.addOpMoviments(Location(verificaPosX, verificaPosY));
            if (possivelPeca == null) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              break;
            } else {
              break;
            }
            verificaPosX++;
          }

          //VERIFICA SETOR SETOR NEGATIVO Y
          verificaPosX = x;
          verificaPosY = y;

          verificaPosY--;

          while (verificaPosY >= 0) {
            var possivelPeca =
                findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
            element.addOpMoviments(Location(verificaPosX, verificaPosY));
            if (possivelPeca == null) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              break;
            } else {
              break;
            }
            verificaPosY--;
          }

          //VERIFICA SETOR POSITIVO Y
          verificaPosX = x;
          verificaPosY = y;

          verificaPosY++;

          while (verificaPosY <= 7) {
            var possivelPeca =
                findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
            element.addOpMoviments(Location(verificaPosX, verificaPosY));
            if (possivelPeca == null) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              break;
            } else {
              break;
            }
            verificaPosY++;
          }

          break;

        case 'rook':
          verificaPosX = x;
          verificaPosY = y;

          verificaPosX--;

          //VERIFICA SETOR NEGATIVO X
          while (verificaPosX >= 1) {
            var possivelPeca =
                findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
            element.addOpMoviments(Location(verificaPosX, verificaPosY));
            if (possivelPeca == null) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              break;
            } else {
              break;
            }
            verificaPosX--;
          }

          //VERIFICA SETOR POSITIVO X
          verificaPosX = x;
          verificaPosY = y;

          verificaPosX++;

          while (verificaPosX <= 8) {
            var possivelPeca =
                findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
            element.addOpMoviments(Location(verificaPosX, verificaPosY));
            if (possivelPeca == null) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              break;
            } else {
              break;
            }
            verificaPosX++;
          }

          //VERIFICA SETOR SETOR NEGATIVO Y
          verificaPosX = x;
          verificaPosY = y;

          verificaPosY--;

          while (verificaPosY >= 0) {
            var possivelPeca =
                findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
            element.addOpMoviments(Location(verificaPosX, verificaPosY));
            if (possivelPeca == null) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              break;
            } else {
              break;
            }
            verificaPosY--;
          }

          //VERIFICA SETOR POSITIVO Y
          verificaPosX = x;
          verificaPosY = y;

          verificaPosY++;

          while (verificaPosY <= 7) {
            var possivelPeca =
                findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
            element.addOpMoviments(Location(verificaPosX, verificaPosY));
            if (possivelPeca == null) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              break;
            } else {
              break;
            }
            verificaPosY++;
          }

          break;
        case 'king':
          int countx = x - 1;
          int county = y - 1;

          for (var ix = countx; ix < countx + 3; ix++) {
            for (var iy = county; iy < county + 3; iy++) {
              element.addLegalMoviments(Location(ix, iy));
              element.addOpMoviments(Location(ix, iy));
            }
          }

          // Castling
          int line = element.pieceColor.name == 'white' ? 7 : 0;
          if (!element.moved) {
            element.addLegalMoviments(Location(7, line));
            element.addLegalMoviments(Location(3, line));
          }

          break;
      }
    }
  }

  static bool verifica(Location location, ChessPiece piece) {
    if (piece.ilegalMoviments != null) {
      for (Location removes in piece.ilegalMoviments!) {
        if (location.x == removes.x && location.y == removes.y) {
          return true;
        }
      }
    }

    return false;
  }

  static void removeLegalMoviments(List<ChessPiece> tabuleiro) {
    List<Location> removelegalMoviments = [Location(-1, -1)];
    for (ChessPiece piece in tabuleiro) {
      if (piece.legalMoviments != null) {
        for (Location location in piece.legalMoviments!) {
          removelegalMoviments.add(location);
        }
      }
    }

    for (ChessPiece piece in tabuleiro) {
      if (piece.legalMoviments != null) {
        if (removelegalMoviments != null) {
          for (Location location in removelegalMoviments) {
            piece.legalMoviments!.remove(location);
          }
        }
      }
    }
  }
}
