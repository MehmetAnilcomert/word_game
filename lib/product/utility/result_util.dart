/// Utility class for game results logic.
final class ResultUtil {
  ResultUtil._();

  /// Finds the rank of [currentUser] in [sortedScores].
  ///
  /// Returns 1, 2, or 3 for podium positions, else 4.
  static int findRank(
    List<MapEntry<String, int>> sortedScores,
    String currentUser,
  ) {
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