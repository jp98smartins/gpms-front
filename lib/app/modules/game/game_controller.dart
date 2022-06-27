import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

import '../../core/adapters/svg_image_adapter.dart';
import '../../core/data/dtos/menu_config_dto.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_assets.dart';
import 'domain/entities/bishop_entity.dart';
import 'domain/entities/chess/chess_match.dart';
import 'domain/entities/chess_piece_entity.dart';
import 'domain/entities/king_entity.dart';
import 'domain/entities/knight_entity.dart';
import 'domain/entities/pawn_entity.dart';
import 'domain/entities/queen_entity.dart';
import 'domain/entities/rook_entity.dart';
import 'domain/usecases/fetch_menu_config_usecase.dart';

class GameController extends GetxController {
  final IFetchMenuConfigUseCase _fetchMenuConfigUseCase;

  List<ChessPiece> itensTabuleiro = [
    King(PieceColor.black, Location(5, 0)),
    Queen(PieceColor.black, Location(4, 0)),
    Rook(PieceColor.black, Location(1, 0)),
    Rook(PieceColor.black, Location(8, 0)),
    Knight(PieceColor.black, Location(2, 0)),
    Knight(PieceColor.black, Location(7, 0)),
    Bishop(PieceColor.black, Location(3, 0)),
    Bishop(PieceColor.black, Location(6, 0)),
    Pawn(PieceColor.black, Location(1, 1)),
    Pawn(PieceColor.black, Location(3, 1)),
    Pawn(PieceColor.black, Location(4, 1)),
    Pawn(PieceColor.black, Location(5, 1)),
    Pawn(PieceColor.black, Location(2, 1)),
    Pawn(PieceColor.black, Location(6, 1)),
    Pawn(PieceColor.black, Location(7, 1)),
    Pawn(PieceColor.black, Location(8, 1)),
    King(PieceColor.white, Location(5, 7)),
    Queen(PieceColor.white, Location(4, 7)),
    Rook(PieceColor.white, Location(8, 7)),
    Rook(PieceColor.white, Location(1, 7)),
    Knight(PieceColor.white, Location(2, 7)),
    Knight(PieceColor.white, Location(7, 7)),
    Bishop(PieceColor.white, Location(3, 7)),
    Bishop(PieceColor.white, Location(6, 7)),
    Pawn(PieceColor.white, Location(1, 6)),
    Pawn(PieceColor.white, Location(2, 6)),
    Pawn(PieceColor.white, Location(3, 6)),
    Pawn(PieceColor.white, Location(4, 6)),
    Pawn(PieceColor.white, Location(5, 6)),
    Pawn(PieceColor.white, Location(6, 6)),
    Pawn(PieceColor.white, Location(7, 6)),
    Pawn(PieceColor.white, Location(8, 6)),
  ];
  List<ChessPiece> pecasMortas = [];
  ChessMatch chessMatch = ChessMatch(
      currentPlayer: 'Brancas',
      inGame: true,
      pecasMortas: [],
      turn: 1,
      pieceColor: PieceColor.white,
      matchResult: null);

  GameController(this._fetchMenuConfigUseCase);

  MenuConfigDto? menuConfigDto;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool newState) {
    _isLoading = newState;
    update();
  }

  @override
  void onReady() async {
    super.onReady();
    await fetchMenuConfigs();
  }

  Future<void> fetchMenuConfigs() async {
    isLoading = true;
    try {
      final menuConfig = await _fetchMenuConfigUseCase();

      if (menuConfig == null) {
        menuConfigDto = MenuConfigDto.fromMap({
          "game_mode": "1",
          "game_difficulty": "0",
        });
      } else {
        menuConfigDto = menuConfig;
      }
    } catch (e) {
      log("[ GameController.fetchMenuConfigs() ] => $e");
      // Snackbar
    } finally {
      isLoading = false;
    }
  }

  Future<void> finishGame() async {
    isLoading = true;
    try {
      menuConfigDto = null;
      Modular.to.popAndPushNamed(AppRoutes.menuRoute);
      Get.delete<GameController>();
    } catch (e) {
      log("[ GameController.finishGame() ] => $e");
      // Snackbar
    } finally {
      isLoading = false;
    }
  }

  void winDialog(context, color) {
    showDialog(
      builder: (c) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(vertical: 200.0),
          title: SvgImageAdapter.fromAsset(
            AppAssets.award,
            alignment: Alignment.center,
            width: 75.0,
          ),
          content: color == 'black'
              ? const Text(
                  'PRETAS VENCERAM!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                )
              : const Text(
                  'BRANCAS VENCERAM!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
          actions: [
            ElevatedButton(
              onPressed: () => finishGame(),
              child: const Text("NOVO JOGO"),
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      },
      context: context,
    );
  }

  void drawDialog(context) {
    showDialog(
      builder: (c) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(vertical: 200.0),
          title: const Text(
            'EMPATE!',
            textAlign: TextAlign.center,
          ),
          actions: [
            ElevatedButton(
              onPressed: () => finishGame(),
              child: const Text("NOVO JOGO"),
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      },
      context: context,
    );
  }

  void finishDialog(context) {
    showDialog(
      builder: (c) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(vertical: 200.0),
          title: const Text("DESISTIR DO JOGO?"),
          content: const SizedBox(
            height: 2,
          ),
          actions: [
            ElevatedButton(
              onPressed: () => finishGame(),
              child: const Text("DESISTIR DO JOGO"),
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      },
      context: context,
    );
  }

  Future<Null> promotionDialog(List<ChessPiece> tabuleiro, context) async {
    ChessPiece? piece;
    for (ChessPiece p in tabuleiro) {
      if (p.pieceColor == PieceColor.black) {
        if (p.name == "pawn") {
          if (p.location.y == 7) {
            piece = p;
          }
        }
      } else {
        if (p.name == "pawn") {
          if (p.location.y == 0) {
            piece = p;
          }
        }
      }
    }
    if (piece != null) {
      String? returnVal = await showDialog(
        builder: (c) {
          return AlertDialog(
            insetPadding: const EdgeInsets.symmetric(vertical: 200.0),
            title: const Text("Promoção do Peão"),
            content: const SizedBox(
              height: 2,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  arrumaPromotion(tabuleiro, piece, "queen");
                  Navigator.of(context, rootNavigator: true).pop();
                },
                icon: SvgImageAdapter.fromAsset(
                  AppAssets.whiteQueen,
                  alignment: Alignment.center,
                  width: 75.0,
                ),
              ),
              IconButton(
                onPressed: () {
                  arrumaPromotion(tabuleiro, piece, "bishop");
                  Navigator.of(context, rootNavigator: true).pop();
                },
                icon: SvgImageAdapter.fromAsset(
                  AppAssets.whiteBishop,
                  alignment: Alignment.center,
                  width: 75.0,
                ),
              ),
              IconButton(
                onPressed: () {
                  arrumaPromotion(tabuleiro, piece, "knight");
                  Navigator.of(context, rootNavigator: true).pop();
                },
                icon: SvgImageAdapter.fromAsset(
                  AppAssets.whiteKnight,
                  alignment: Alignment.center,
                  width: 75.0,
                ),
              ),
              IconButton(
                onPressed: () {
                  arrumaPromotion(tabuleiro, piece, "rook");
                  Navigator.of(context, rootNavigator: true).pop();
                },
                icon: SvgImageAdapter.fromAsset(
                  AppAssets.whiteRook,
                  alignment: Alignment.center,
                  width: 75.0,
                ),
              ),
            ],
            actionsAlignment: MainAxisAlignment.center,
          );
        },
        context: context,
      );
    }
  }

  void arrumaPromotion(List<ChessPiece> pieces, ChessPiece? pawn, String nome) {
    if (pawn != null) {
      // Destroy pawn
      Location pawnOldLocation = Location(pawn.location.x, pawn.location.y);
      PieceColor pawnColor = pawn.pieceColor;
      pawn.location.x = -1;
      pawn.location.y = -1;
      pawn.died = true;
      pawn.legalMoviments = null;
      pawn.ilegalMoviments = null;
      pawn.opMoviments = null;
      // Create new piece
      switch (nome) {
        case 'queen':
          ChessPiece queen = Queen(pawnColor, pawnOldLocation);
          pieces.add(queen);
          break;
        case 'rook':
          ChessPiece rook = Rook(pawnColor, pawnOldLocation);
          pieces.add(rook);
          break;
        case 'bishop':
          ChessPiece bishop = Bishop(pawnColor, pawnOldLocation);
          pieces.add(bishop);
          break;
        case 'knight':
          ChessPiece knight = Knight(pawnColor, pawnOldLocation);
          pieces.add(knight);
          break;
      }
    }
  }
}
