import 'dart:developer';

import 'package:get/get.dart';
import 'package:gpms/app/modules/game/domain/entities/chess/chess_match.dart';

import '../../core/data/dtos/menu_config_dto.dart';
import 'domain/entities/bishop_entity.dart';
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
  );

  GameController(this._fetchMenuConfigUseCase);

  late final MenuConfigDto menuConfigDto;

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
    try {} catch (e) {
      log("[ GameController.finishGame() ] => $e");
      // Snackbar
    } finally {
      isLoading = false;
    }
  }
}
