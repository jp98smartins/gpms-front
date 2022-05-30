import '../entities/chess_piece_entity.dart';

bool verifyLocationInList(List<Location>? locations, Location location) {
  if (locations != null) {
    for (Location aLocation in locations) {
      if (aLocation.x == location.x && aLocation.y == location.y) {
        return true;
      }
    }
  }
  return false;
}
