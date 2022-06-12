import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/adapters/svg_image_adapter.dart';
import '../../../core/theme/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../domain/entities/chess_piece_entity.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard({
    Key? key,
    required this.color,
    required this.diedPieces,
  }) : super(key: key);

  final String color;
  final List<ChessPiece> diedPieces;

  Widget get playerName {
    return Text(
      color == "black" ? "JOGADOR DE PRETAS" : "JOGADOR DE BRANCAS",
      style: TextStyle(
        color: color == "black"
            ? AppColors.foregroundTertiary
            : AppColors.foregroundPrimary,
      ),
    );
  }

  Widget get playerIcon {
    return SvgImageAdapter.fromAsset(
      color == "black" ? AppAssets.blackAvatar : AppAssets.whiteAvatar,
      alignment: Alignment.centerLeft,
      width: 50.0,
    );
  }

  List<Widget> get diedPiecesWidgets {
    if (color == "black") {
      return diedPieces.map((onePiece) {
        if (onePiece.pieceColor == PieceColor.white) {
          return SvgImageAdapter.fromAsset(
            "assets/images/${onePiece.name}/white_${onePiece.name}.svg",
            alignment: Alignment.centerLeft,
            width: 16,
          );
        }

        return Container();
      }).toList();
    }

    return diedPieces.map((onePiece) {
      if (onePiece.pieceColor == PieceColor.black) {
        return SvgImageAdapter.fromAsset(
          "assets/images/${onePiece.name}/black_${onePiece.name}.svg",
          alignment: Alignment.centerLeft,
          width: 16,
        );
      }

      return Container();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(flex: 2, child: playerIcon),
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: playerName),
                Expanded(child: Row(children: diedPiecesWidgets))
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(8.0),
      ),
      height: 70.0,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      width: Get.width,
    );
  }
}
