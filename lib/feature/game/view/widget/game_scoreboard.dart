part of '../game_view.dart';

class _GameScoreboard extends StatelessWidget {

  const _GameScoreboard({required this.scores, required this.usedWords});

  final Map<String, int> scores;
  final Map<String, List<dynamic>> usedWords;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colorScheme.surface.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: context.appColors.cardShadow,
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              LocaleKeys.scoreTableLabel.tr(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: scores.entries
                    .map((e) => _PlayerWordBoard(
                          words: (usedWords[e.key] ?? []).cast<String>(),
                        ),)
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlayerWordBoard extends StatelessWidget {

  const _PlayerWordBoard({required this.words});

  final List<String> words;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: words
                .map((word) => Text(
                      word,
                      style: TextStyle(
                        fontSize: 14,
                        color: context.colorScheme.onSurface,
                      ),
                    ),)
                .toList(),
          ),
        ],
      ),
    );
  }
}
