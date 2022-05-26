import 'package:gpms/app/modules/game/domain/entities/bishop_entity.dart';

import '../entities/chess_piece_entity.dart';

class GenerateAllLegalMoviments {
  static void gerarMovimentos(List<ChessPiece> tabuleiro) {
    tabuleiro.forEach((element) {
      switch (element.name) {
        case 'bishop':
          // int x = element.location.x;
          // int y = element.location.y;

          // //vai verificar os quatro quadrantes
          // while (x < 9 && y < 8) {
          //   if (x != element.location.x && y != element.location.y) {
          //     var novaLocation = Location(x, y);
          //     element.addLegalMoviments(novaLocation);
          //   }
          // }
          break;

        case 'king':
          break;

        case 'knight':
          break;

        case 'pawn':
          break;

        case 'queen':
          break;

        case 'rook':
        // var x = element.location.x;
        // var y = element.location.y;
        // for (x < 9) {
        //   var novaLocation = Location(x, y);
        // }
        // break;
      }
    });
  }
}
