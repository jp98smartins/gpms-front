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
  List<Location>? opMoviments;
  List<Location>? legalMoviments;
  List<Location>? ilegalMoviments;
  String promotion;

  ChessPiece({
    required this.died,
    required this.moved,
    required this.name,
    required this.pieceColor,
    required this.value,
    required this.location,
    required this.promotion,
  });

  Widget get image;

  void addOpMoviments(Location location) {
    if (opMoviments == null) {
      opMoviments = [location];
    } else {
      opMoviments?.add(location);
    }
  }

  void remOpMoviments(Location location) {
    opMoviments!.remove(location);
  }

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
