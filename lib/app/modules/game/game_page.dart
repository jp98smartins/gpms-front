import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:gpms/app/core/theme/app_colors.dart';
import 'package:gpms/app/modules/game/game_controller.dart';

import '../../core/adapters/svg_image_adapter.dart';
import '../../core/theme/app_assets.dart';
import 'domain/entities/Bishop_entity.dart';
import 'domain/entities/chess_piece_entity.dart';
import 'domain/entities/king_entity.dart';
import 'domain/entities/knight_entity.dart';
import 'domain/entities/queen_entity.dart';
import 'domain/entities/rook_entity.dart';

import 'domain/entities/pawn_entity.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  GamePageState createState() => GamePageState();
}

List<ChessPiece> itensTabuleiro = [
  Rook(PieceColor.black, Location(1, 0)),
  Knight(PieceColor.black, Location(2, 0)),
  Bishop(PieceColor.black, Location(3, 0)),
  Queen(PieceColor.black, Location(4, 0)),
  King(PieceColor.black, Location(5, 0)),
  Bishop(PieceColor.black, Location(6, 0)),
  Knight(PieceColor.black, Location(7, 0)),
  Rook(PieceColor.black, Location(8, 0)),
  Pawn(PieceColor.black, Location(1, 1)),
  Pawn(PieceColor.black, Location(3, 1)),
  Pawn(PieceColor.black, Location(4, 1)),
  Pawn(PieceColor.black, Location(5, 1)),
  Pawn(PieceColor.black, Location(2, 1)),
  Pawn(PieceColor.black, Location(6, 1)),
  Pawn(PieceColor.black, Location(7, 1)),
  Pawn(PieceColor.black, Location(8, 1)),
  Pawn(PieceColor.white, Location(1, 6)),
  Pawn(PieceColor.white, Location(2, 6)),
  Pawn(PieceColor.white, Location(3, 6)),
  Pawn(PieceColor.white, Location(4, 6)),
  Pawn(PieceColor.white, Location(5, 6)),
  Pawn(PieceColor.white, Location(6, 6)),
  Pawn(PieceColor.white, Location(7, 6)),
  Pawn(PieceColor.white, Location(8, 6)),
  Rook(PieceColor.white, Location(1, 7)),
  Knight(PieceColor.white, Location(2, 7)),
  Bishop(PieceColor.white, Location(3, 7)),
  Queen(PieceColor.white, Location(4, 7)),
  King(PieceColor.white, Location(5, 7)),
  Bishop(PieceColor.white, Location(6, 7)),
  Knight(PieceColor.white, Location(7, 7)),
  Rook(PieceColor.white, Location(8, 7)),
];
var posicoesY = ['', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
var posicoesX = ['1', '2', '3', '4', '5', '6', '7', '8', ''];

class GamePageState extends State<GamePage> {
  final controller = Modular.get<GameController>();
  late final double widthTile = MediaQuery.of(context).size.width / 9.5;
  var pecaAnterior = -1;
  Location ultimo = Location(-1, -1);

  @override
  Widget build(BuildContext context) {
    controller.fetchMenuConfigs(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgImageAdapter.fromAsset(AppAssets.whiteIcon),
        ),
        title: const Text("xadrez"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(),
          Container(),
          Column(
            children: [
              ...List.generate(
                9,
                (y) => Row(
                  children: [
                    ...List.generate(
                      9,
                      (x) => Container(
                        decoration: BoxDecoration(
                          color: pickBoardPositionColor(x, y),
                        ),
                        width: widthTile,
                        height: widthTile,
                        child: escolheContainerFilho(x, y),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Container(),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),gi
    );
  }

  /// Method that picks the right color for the position on the board.
  ///
  /// @param [int x] position x of the board.
  /// @param [int y] position y of the board.
  ///
  /// @return Color [ AppColors.backgroundPrimary, AppColors.lightBoardPosition, AppColors.darkBoardPosition ]
  Color pickBoardPositionColor(int x, int y) {
    // Cor das Letras/Números das casas do tabuleiro
    if (x == 0 || y == 8) return AppColors.backgroundPrimary;

    // Casas Claras do Tabuleiro
    if ((x.isEven && y.isOdd) || (x.isOdd && y.isEven)) {
      return AppColors.lightBoardPosition;
    }

    // Casas Escuras do Tabuleiro
    return AppColors.darkBoardPosition;
  }

  Widget escolheContainerFilho(int x, int y) {
    //definição linha e coluna
    if (x == 0) {
      return Center(
          child: Text(
        '$posicoesX[y]',
        style: Theme.of(context).textTheme.caption,
      ));
    }
    if (y == 8) {
      return Center(
          child: Text(
        '$posicoesY[x]',
        style: Theme.of(context).textTheme.caption,
      ));
    }

    var possivelPecaAtual = encontraPeca(Location(x, y));
    return Padding(
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith(
          (states) => (ultimo.x == x && ultimo.y == y)
              ? Colors.red.withOpacity(0.6)
              : Colors.black.withOpacity(0.0),
        )),
        onPressed: () {
          if (ultimo.x == -1 && ultimo.y == -1 && possivelPecaAtual != null) {
            ultimo.x = x;
            ultimo.y = y;
          } else {
            final possivelPecaAntiga = encontraPeca(ultimo);
            if (possivelPecaAntiga != null) {
              possivelPecaAntiga.location.x = x;
              possivelPecaAntiga.location.y = y;
            }

            ultimo.x = -1;
            ultimo.y = -1;
          }
          setState(() {});
        },
        child: Center(
          child: encontraPeca(Location(x, y)) == null
              ? Text('$x $y')
              : possivelPecaAtual!.image,
        ),
      ),
      padding: const EdgeInsets.all(5),
    );
  }

  ChessPiece? encontraPeca(Location location) {
    for (ChessPiece chessPiece in itensTabuleiro) {
      if (chessPiece.location.x == location.x &&
          chessPiece.location.y == location.y) {
        return chessPiece;
      }
    }
    return null;
  }
}
