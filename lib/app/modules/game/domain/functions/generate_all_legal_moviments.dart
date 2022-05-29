import 'package:gpms/app/modules/game/domain/functions/find_piece.dart';

import '../entities/chess_piece_entity.dart';

class GenerateAllLegalMoviments {
  static void gerarMovimentos(List<ChessPiece> tabuleiro) {
    for (var element in tabuleiro) {
      int x = element.location.x;
      int y = element.location.y;
      element.legalMoviments = null;
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
        case 'king':
          int countx = 0;
          int county = 0;
          verificaPosX = x;
          verificaPosX--;
          while (countx < 3) {
            verificaPosY = y;
            verificaPosY--;
            county = 0;
            while (county < 3) {
              var possivelPeca =
                  findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
              if (possivelPeca == null ||
                  possivelPeca.pieceColor != element.pieceColor) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
              verificaPosY++;
              county++;
            }
            verificaPosX++;
            countx++;
          }
          break;

        case 'knight':
          void verificaAddPosicaoCavalo(int verificaPosX, int verificaPosY) {
            var possivelPeca =
                findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
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
          if (element.pieceColor == PieceColor.black) {
            verificaPosY++;
          } else {
            verificaPosY--;
          }
          var posivelPeca =
              findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
          if (posivelPeca == null) {
            element.addLegalMoviments(Location(verificaPosX, verificaPosY));
          }
          verificaPosX--;
          posivelPeca =
              findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
          if (posivelPeca != null) {
            element.addLegalMoviments(Location(verificaPosX, verificaPosY));
          }
          verificaPosX += 2;
          posivelPeca =
              findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
          if (posivelPeca != null) {
            element.addLegalMoviments(Location(verificaPosX, verificaPosY));
          }

          if (element.moved == false) {
            verificaPosX = x;
            verificaPosY = y;
            if (element.pieceColor == PieceColor.black) {
              verificaPosY += 2;
            } else {
              verificaPosY -= 2;
            }
            var posivelPeca =
                findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
            if (posivelPeca == null) {
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
      }
    }
  }
}
