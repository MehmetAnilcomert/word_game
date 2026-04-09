part of '../result_view.dart';

class _ResultWinner extends StatelessWidget {

  const _ResultWinner({required this.sortedScores});
  final List<MapEntry<String, int>> sortedScores;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              LocaleKeys.winnerLabel.tr(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              sortedScores.isNotEmpty
                  ? sortedScores.first.key
                  : LocaleKeys.noWinner.tr(),
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: context.appColors.goldColor,),
            ),
            const SizedBox(height: 8),
            Icon(
              Icons.emoji_events,
              color: context.appColors.goldColor,
              size: 64,
            ),
          ],
        ),
      ),
    );
  }
}
