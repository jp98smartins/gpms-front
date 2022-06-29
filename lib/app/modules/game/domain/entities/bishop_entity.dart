import 'package:flutter/material.dart';

import '../../../../core/adapters/svg_image_adapter.dart';
import '../../../../core/theme/app_assets.dart';
import 'chess_piece_entity.dart';

class Bishop extends ChessPiece {
  Bishop(PieceColor pieceColor, Location location)
      : super(
          died: false,
          moved: false,
          name: 'bishop',
          pieceColor: pieceColor,
          value: 3,
          location: location,
          promotion: '',
        );

  @override
  @override
  Widget get image => SvgImageAdapter.fromAsset(
        pieceColor == PieceColor.white
            ? AppAssets.whiteBishop
            : AppAssets.blackBishop,
      );
}
