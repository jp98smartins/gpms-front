import '../entities/chess_piece_entity.dart';

class VerifyMoviment {
  static bool verifyMoviment(List<Location>? locations, Location location,
      List<ChessPiece> tabuleiro, List<ChessPiece> pecasMortas) {
    if (locations != null) {
      for (Location aLocation in locations) {
        if (aLocation.x == location.x && aLocation.y == location.y) {
          for (ChessPiece piece in tabuleiro) {
            if (piece.location.x == location.x &&
                piece.location.y == location.y) {
              piece.died = true;
              piece.location = Location(-1, -1);

              pecasMortas.add(piece);
            }
          }
          return true;
        }
      }
    }
    return false;
  }
}
