import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpms/app/core/adapters/svg_image_adapter.dart';
import 'package:gpms/app/core/theme/app_assets.dart';
import 'package:gpms/app/core/theme/app_colors.dart';
import 'package:gpms/app/modules/game/domain/entities/chess_piece_entity.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard(
      {Key? key,
      required this.pecasMortas,
      required this.color,
      required this.itensTabuleiro})
      : super(key: key);

  final List<ChessPiece> pecasMortas;
  final List<ChessPiece> itensTabuleiro;

  final String color;

  Widget getvisibility(
      List<ChessPiece> tabuleiro, List<ChessPiece> apoio, String color) {
    PieceColor cor;
    String inversoColor;

    if (color == "black") {
      cor = PieceColor.white;
    } else {
      cor = PieceColor.black;
    }

    if (color == "black") {
      inversoColor = "white";
    } else {
      inversoColor = "black";
    }

    for (ChessPiece piece in tabuleiro) {
      if (piece.pieceColor == cor) {
        if (!apoio.contains(piece)) {
          if (piece.name != "king") {
            apoio.add(piece);
            print(" Visibility ${piece.died}");
            return Visibility(
              visible: piece.died,
              child: SvgImageAdapter.fromAsset(
                  "assets/images/${piece.name}/${inversoColor}_${piece.name}.svg",
                  alignment: Alignment.centerLeft,
                  width: 20),
            );
          }
        }
      }
    }
    return Visibility(
      visible: false,
      child: SvgImageAdapter.fromAsset(AppAssets.whiteQueen,
          alignment: Alignment.centerLeft, width: 20),
    );
  }

  Widget getName(String color) {
    var texto = "";
    Color cor;

    if (color == "black") {
      texto = "  JOGADOR DE PRETAS";
      cor = Colors.black;
    } else {
      texto = "  JOGADOR DE BRANCAS";
      cor = Colors.white;
    }

    return Text(
      texto,
      textDirection: TextDirection.ltr,
      style: TextStyle(
        fontSize: 20,
        color: cor,
      ),
    );
  }

  Widget getIcon(String color) {
    var path = "";
    if (color == "black") {
      path = "assets/images/avatars/black_pieces_avatar.svg";
    } else {
      path = "assets/images/avatars/white_pieces_avatar.svg";
    }

    return SvgImageAdapter.fromAsset(path,
        alignment: Alignment.centerLeft, width: 50);
  }

  @override
  Widget build(BuildContext context) {
    List<ChessPiece> listApoio = [];
    return Container(
      decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(5)),
      height: Get.width / 8,
      width: Get.width - 10,
      child: Row(
        children: [
          getIcon(color),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getName(color),
              Row(
                children: [
                  ...List.generate(
                    15,
                    (x) => getvisibility(itensTabuleiro, listApoio, color),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
