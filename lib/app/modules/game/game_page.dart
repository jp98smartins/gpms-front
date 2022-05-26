import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import '../../core/adapters/svg_image_adapter.dart';
import '../../core/theme/app_assets.dart';
import 'domain/entities/Bishop_entity.dart';
import 'domain/entities/chess_piece_entity.dart';
import 'domain/entities/king_entity.dart';
import 'domain/entities/knight_entity.dart';
import 'domain/entities/queen_entity.dart';
import 'domain/entities/rook_entity.dart';

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
var posicoesY = ['', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
var posicoesX = ['8', '7', '6', '5', '4', '3', '2', '1', ''];

class GamePageState extends State<GamePage> {
  final GameBloc bloc = Modular.get();
  late final double widthTile = MediaQuery.of(context).size.width / 9.5;
  var pecaAnterior = -1;
  var corClaro = Color.fromARGB(255, 164, 177, 214);
  var corEscuro = Color.fromARGB(255, 63, 97, 207);
  var corFundoNormal = const Color.fromRGBO(52, 52, 52, 1);
  Location ultimo = Location(-1, -1);

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
      //Escolher cor da casa no tabuleiro
      return corFundoNormal;
    }
    if ((x.isEven && y.isOdd) || (x.isOdd && y.isEven)) {
      return corClaro;
    }
    return corEscuro;
  }

  Container escolheContainerFilho(int x, int y) {
    //definição linha e coluna
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

    var possivelPecaAtual = encontraPeca(Location(x, y));
    return Container(
      child: FlatButton(
        color: (ultimo.x == x && ultimo.y == y)
            ? Colors.red.withOpacity(0.6)
            : Colors.black.withOpacity(0.0),
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
              ? Text('')
              : possivelPecaAtual!.image,
        ),
        padding: const EdgeInsets.all(5),
      ),
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
