class ResultUtil {
  static int findRank(
      List<MapEntry<String, int>> sortedScores, String currentUser) {
    if (sortedScores.isNotEmpty && sortedScores[0].key == currentUser) {
      return 1;
    } else if (sortedScores.length > 1 && sortedScores[1].key == currentUser) {
      return 2;
    } else if (sortedScores.length > 2 && sortedScores[2].key == currentUser) {
      return 3;
    } else {
      return 4;
    }
  }
}
