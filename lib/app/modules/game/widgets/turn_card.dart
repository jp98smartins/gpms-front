// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gpms/app/core/theme/app_colors.dart';

import '../domain/entities/chess/chess_match.dart';

class TurnCard extends StatefulWidget {
  TurnCard({
    Key? key,
    required this.chessMatch,
  }) : super(key: key);
  ChessMatch chessMatch;
  @override
  State<TurnCard> createState() => _TurnCardState();
}

class _TurnCardState extends State<TurnCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(5)),
      height: Get.width / 12,
      width: Get.width - 10,
      child: Center(
        child: Text(
          textCurrentColor(widget.chessMatch.currentPlayer),
          textDirection: TextDirection.ltr,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  String textCurrentColor(String currentColor) {
    return 'Vez das ' + currentColor;
  }
}
