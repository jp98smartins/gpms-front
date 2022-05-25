import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import '../../core/adapters/svg_image_adapter.dart';
import '../../core/theme/app_assets.dart';
import 'bloc/game_bloc.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  GamePageState createState() => GamePageState();
}

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
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.home),
          ),
          title: const Text("xadrez")),
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
    return Container();
  }
}



//  setState(() {
//                           if (pecaAnterior == -1) {
//                             pecaAnterior = i;
//                           } else {
//                             tabuleiro[i] = tabuleiro[pecaAnterior];
//                             tabuleiro[pecaAnterior] = 'vazio';
//                             pecaAnterior = -1;
//                           }
//                         });
