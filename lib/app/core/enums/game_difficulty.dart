enum GameDifficulty { easy, medium, hard }

GameDifficulty gameDifficultyFromIndex(int index) {
  switch (index) {
    case 0:
      return GameDifficulty.easy;
    case 1:
      return GameDifficulty.medium;
    case 2:
      return GameDifficulty.hard;
    default:
      return GameDifficulty.easy;
  }
}
