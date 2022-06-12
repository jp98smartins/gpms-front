import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../domain/entities/chess/chess_match.dart';

class TurnCard extends StatelessWidget {
  const TurnCard({Key? key, required this.chessMatch}) : super(key: key);

  final ChessMatch chessMatch;

  String get activeTurn => 'VEZ DAS ${chessMatch.currentPlayer.toUpperCase()}';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          activeTurn,
          style: TextStyle(
            color: chessMatch.currentPlayer.toUpperCase() == "PRETAS"
                ? AppColors.foregroundTertiary
                : AppColors.foregroundPrimary,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(8.0),
      ),
      height: 40.0,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(5.0),
      width: Get.width,
    );
  }
}
