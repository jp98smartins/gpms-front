enum GameMode { pvp, pve, eve }

GameMode gameModeFromIndex(int index) {
  switch (index) {
    case 0:
      return GameMode.pvp;
    case 1:
      return GameMode.pve;
    case 2:
      return GameMode.eve;
    default:
      return GameMode.pve;
  }
}
