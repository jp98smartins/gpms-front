import 'dart:developer';

import 'package:flutter/cupertino.dart';

enum PieceColor { black, white }

class Location {
  int x;
  int y;

  Location(this.x, this.y);

  bool get isValid => (x >= 0 && x <= 7) && (y >= 1 && y <= 8);
}

abstract class ChessPiece {
  bool died;
  bool moved;
  final String name;
  final PieceColor pieceColor;
  final int value;
  Location location;
  List<Location>? legalMoviments;
  List<Location>? ilegalMoviments;

  ChessPiece({
    required this.died,
    required this.moved,
    required this.name,
    required this.pieceColor,
    required this.value,
    required this.location,
  });

  Widget get image;

  void addLegalMoviments(Location location) {
    if (legalMoviments == null) {
      legalMoviments = [location];
    } else {
      legalMoviments?.add(location);
    }
  }

  void remLegalMoviments(Location location) {
    legalMoviments!.remove(location);
  }

  void addIlegalMoviments(Location location) {
    if (ilegalMoviments == null) {
      ilegalMoviments = [location];
    } else {
      ilegalMoviments?.add(location);
    }
  }

  void remIlegalMoviments(Location location) {
    ilegalMoviments!.remove(location);
  }
}
