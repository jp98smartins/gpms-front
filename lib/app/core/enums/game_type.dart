enum GameType { pve, pvp, eve }

GameType gameTypeFromIndex(int index) {
  switch (index) {
    case 0:
      return GameType.pve;
    case 1:
      return GameType.pvp;
    case 2:
      return GameType.eve;
    default:
      return GameType.pve;
  }
}
