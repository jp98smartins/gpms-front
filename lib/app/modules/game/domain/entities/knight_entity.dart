import 'package:flutter/material.dart';

import '../../../../core/adapters/svg_image_adapter.dart';
import '../../../../core/theme/app_assets.dart';
import 'chess_piece_entity.dart';

class Knight extends ChessPiece {
  Knight(PieceColor pieceColor, Location location)
      : super(
          died: false,
          moved: false,
          name: 'knight',
          value: 3,
          pieceColor: pieceColor,
          location: location,
          promotion: '',
        );

  @override
  @override
  Widget get image => SvgImageAdapter.fromAsset(
        pieceColor == PieceColor.white
            ? AppAssets.whiteKnight
            : AppAssets.blackKnight,
      );
}
