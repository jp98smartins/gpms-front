import 'package:flutter/material.dart';

import '../../../../core/adapters/svg_image_adapter.dart';
import '../../../../core/theme/app_assets.dart';
import 'chess_piece_entity.dart';

class Queen extends ChessPiece {
  Queen(PieceColor pieceColor, Location location)
      : super(
          died: false,
          moved: false,
          name: 'queen',
          pieceColor: pieceColor,
          value: 9,
          location: location,
        );

  @override
  @override
  Widget get image => SvgImageAdapter.fromAsset(
        pieceColor == PieceColor.white
            ? AppAssets.whiteQueen
            : AppAssets.blackQueen,
      );
}
