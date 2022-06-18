import 'dart:developer';

import '../entities/chess_piece_entity.dart';
import 'find_piece.dart';

class GenerateAllLegalMoviments {
  //RECEBE O TABULEIRO E GERA TODOS OS MOVIEMTOS DE CADA PEÇA, SEM VALIDAÇÕES DE XEQUE
  static void gerarMovimentos(List<ChessPiece> tabuleiro) async {
    //removeLegalMoviments(tabuleiro);
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
          var possivelPeca =
              findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
          if (possivelPeca == null) {
            element.addLegalMoviments(Location(verificaPosX, verificaPosY));
          }
          verificaPosX--;
          possivelPeca =
              findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
          if (possivelPeca != null &&
              possivelPeca.pieceColor != element.pieceColor) {
            element.addLegalMoviments(Location(verificaPosX, verificaPosY));
          }
          verificaPosX += 2;
          possivelPeca =
              findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
          if (possivelPeca != null &&
              possivelPeca.pieceColor != element.pieceColor) {
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
        case 'king':
          int countx = 0;
          int county = 0;
          int contNot = 0;
          var elementColor = element.pieceColor;
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
                for (ChessPiece piece in tabuleiro) {
                  // ignore: unrelated_type_equality_checks
                  if (piece.pieceColor != elementColor) {
                    if (piece.legalMoviments != null) {
                      for (Location legalMoviment in piece.legalMoviments!) {
                        if (verificaPosX == legalMoviment.x &&
                            verificaPosY == legalMoviment.y) {
                          contNot += 1;
                        }
                      }
                    }
                  }
                }
                if (contNot == 0) {
                  element
                      .addLegalMoviments(Location(verificaPosX, verificaPosY));
                }
              }
              verificaPosY++;
              county++;
            }
            verificaPosX++;
            countx++;
          }
          break;
      }
    }
  }
  //
  //

  //

  static void gerarMovimentosNEW(
      List<ChessPiece> tabuleiro, List<Location> remove) {
    //removeLegalMoviments(tabuleiro);
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
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
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
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
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
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
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
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
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
                if (!remove.any((elements) =>
                    verifica(Location(verificaPosX, verificaPosY), element))) {
                  element
                      .addLegalMoviments(Location(verificaPosX, verificaPosY));
                }
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
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
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
          var possivelPeca =
              findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
          if (possivelPeca == null) {
            if (!remove.any((elements) =>
                verifica(Location(verificaPosX, verificaPosY), element))) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
            }
          }
          verificaPosX--;
          possivelPeca =
              findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
          if (possivelPeca != null &&
              possivelPeca.pieceColor != element.pieceColor) {
            if (!remove.any((elements) =>
                verifica(Location(verificaPosX, verificaPosY), element))) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
            }
          }
          verificaPosX += 2;
          possivelPeca =
              findPiece(tabuleiro, Location(verificaPosX, verificaPosY));
          if (possivelPeca != null &&
              possivelPeca.pieceColor != element.pieceColor) {
            if (!remove.any((elements) =>
                verifica(Location(verificaPosX, verificaPosY), element))) {
              element.addLegalMoviments(Location(verificaPosX, verificaPosY));
            }
          }

          if (element.moved == false) {
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
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
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
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
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
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
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
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
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
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }

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
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
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
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
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
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
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
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
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
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
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
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
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
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
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
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
            } else if (possivelPeca.pieceColor != element.pieceColor) {
              if (!remove.any((elements) =>
                  verifica(Location(verificaPosX, verificaPosY), element))) {
                element.addLegalMoviments(Location(verificaPosX, verificaPosY));
              }
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
