import 'package:flutter/material.dart';

import '../../../../core/adapters/svg_image_adapter.dart';
import '../../../../core/theme/app_assets.dart';
import 'chess_piece_entity.dart';

class Rook extends ChessPiece {
  Rook(PieceColor pieceColor, Location location)
      : super(
          died: false,
          moved: false,
          name: 'rook',
          pieceColor: pieceColor,
          value: 5,
          location: location,
          promotion: '',
        );

  @override
  @override
  Widget get image => SvgImageAdapter.fromAsset(
        pieceColor == PieceColor.white
            ? AppAssets.whiteRook
            : AppAssets.blackRook,
      );
}
