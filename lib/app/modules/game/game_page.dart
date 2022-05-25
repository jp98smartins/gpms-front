import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:gpms/app/core/adapters/svg_image_adapter.dart';
import 'package:gpms/app/core/theme/app_assets.dart';
import 'package:gpms/app/modules/game/domain/entities/Bishop_entity.dart';
import 'package:gpms/app/modules/game/domain/entities/chess_piece_entity.dart';
import 'package:gpms/app/modules/game/domain/entities/king_entity.dart';
import 'package:gpms/app/modules/game/domain/entities/knight_entity.dart';
import 'package:gpms/app/modules/game/domain/entities/queen_entity.dart';
import 'package:gpms/app/modules/game/domain/entities/rook_entity.dart';

import 'bloc/game_bloc.dart';
import 'domain/entities/pawn_entity.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  GamePageState createState() => GamePageState();
}

List<ChessPiece> itensTabuleiro = [
  Rook(PieceColor.black, Location(0, 1)),
  Knight(PieceColor.black, Location(0, 2)),
  Bishop(PieceColor.black, Location(0, 3)),
  Queen(PieceColor.black, Location(0, 4)),
  King(PieceColor.black, Location(0, 5)),
  Bishop(PieceColor.black, Location(0, 6)),
  Knight(PieceColor.black, Location(0, 7)),
  Rook(PieceColor.black, Location(0, 8)),
  Pawn(PieceColor.black, Location(1, 1)),
  Pawn(PieceColor.black, Location(1, 3)),
  Pawn(PieceColor.black, Location(1, 4)),
  Pawn(PieceColor.black, Location(1, 5)),
  Pawn(PieceColor.black, Location(1, 2)),
  Pawn(PieceColor.black, Location(1, 6)),
  Pawn(PieceColor.black, Location(1, 7)),
  Pawn(PieceColor.black, Location(1, 8)),
  Pawn(PieceColor.white, Location(6, 1)),
  Pawn(PieceColor.white, Location(6, 2)),
  Pawn(PieceColor.white, Location(6, 3)),
  Pawn(PieceColor.white, Location(6, 4)),
  Pawn(PieceColor.white, Location(6, 5)),
  Pawn(PieceColor.white, Location(6, 6)),
  Pawn(PieceColor.white, Location(6, 7)),
  Pawn(PieceColor.white, Location(6, 8)),
  Rook(PieceColor.white, Location(7, 1)),
  Knight(PieceColor.white, Location(7, 2)),
  Bishop(PieceColor.white, Location(7, 3)),
  Queen(PieceColor.white, Location(7, 4)),
  King(PieceColor.white, Location(7, 5)),
  Bishop(PieceColor.white, Location(7, 6)),
  Knight(PieceColor.white, Location(7, 7)),
  Rook(PieceColor.white, Location(7, 8)),
];

class GamePageState extends State<GamePage> {
  final GameBloc bloc = Modular.get();
  late final double widthTile = MediaQuery.of(context).size.width / 9.5;
  var tabuleiro = List.filled(64, 'vazio');
  var pecaAnterior = -1;
  var corClaro = const Color.fromRGBO(205, 212, 215, 1);
  var corEscuro = const Color.fromRGBO(117, 153, 186, 1);
  var corFundoNormal = const Color.fromRGBO(52, 52, 52, 1);

  @override
  Widget build(BuildContext context) {
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
                (x) => Row(
                  children: [
                    ...List.generate(
                      9,
                      (y) => Container(
                        // ignore: prefer_const_constructors
                        decoration: BoxDecoration(
                          color: escolheCor(x, y),
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
      ),
    );
  }

  Color escolheCor(int x, int y) {
    if (x == 8 || y == 0) {
      return corFundoNormal;
    }
    if ((x.isEven && y.isOdd) || (x.isOdd && y.isEven)) {
      return corClaro;
    }
    return corEscuro;
  }

  Container escolheContainerFilho(int x, int y) {
    var posicoesY = ['', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
    var posicoesX = ['8', '7', '6', '5', '4', '3', '2', '1', ''];
    if (x == 8) {
      return Container(
        child: Center(
            child: Text(
          '${posicoesY[y]}',
          style: Theme.of(context).textTheme.caption,
        )),
      );
    }
    if (y == 0) {
      return Container(
        child: Center(
            child: Text(
          '${posicoesX[x]}',
          style: Theme.of(context).textTheme.caption,
        )),
      );
    }

    for (ChessPiece chessPiece in itensTabuleiro) {
      if (chessPiece.location.x == x && chessPiece.location.y == y) {
        return Container(
          child: Center(
            child: chessPiece.image,
          ),
          padding: const EdgeInsets.all(5),
        );
      }
    }

    return Container(
      child: Center(
        child: Text(''),
      ),
      padding: const EdgeInsets.all(5),
    );
  }
}

// Widget