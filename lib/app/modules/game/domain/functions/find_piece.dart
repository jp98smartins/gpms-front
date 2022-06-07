import '../entities/chess_piece_entity.dart';

ChessPiece? findPiece(List<ChessPiece> itensTabuleiro, Location location) {
  for (ChessPiece chessPiece in itensTabuleiro) {
    if (chessPiece.location.x == location.x &&
        chessPiece.location.y == location.y) {
      return chessPiece;
    }
  }
  return null;
}
