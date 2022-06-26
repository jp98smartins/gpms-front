import 'package:flutter/material.dart';

import '../../../../core/adapters/svg_image_adapter.dart';
import '../../../../core/theme/app_assets.dart';
import 'chess_piece_entity.dart';

class Pawn extends ChessPiece {
  Pawn(PieceColor pieceColor, Location location)
      : super(
          died: false,
          moved: false,
          name: 'pawn',
          pieceColor: pieceColor,
          value: 1,
          location: location,
          promotion: '',
        );

  @override
  @override
  Widget get image => SvgImageAdapter.fromAsset(
        pieceColor == PieceColor.white
            ? AppAssets.whitePawn
            : AppAssets.blackPawn,
      );
}
