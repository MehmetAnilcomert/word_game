part of '../result_view.dart';

class _ResultScoreTable extends StatelessWidget {
  final List<MapEntry<String, int>> sortedScores;

  const _ResultScoreTable({required this.sortedScores});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'scoreTableLabel'.tr(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...sortedScores.asMap().entries.map((entry) {
              final index = entry.key;
              final score = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    _buildMedal(index),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        score.key,
                        style:
                            const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      score.value.toString(),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMedal(int index) {
    IconData icon;
    Color color;
    switch (index) {
      case 0:
        icon = Icons.looks_one;
        color = Colors.amber;
        break;
      case 1:
        icon = Icons.looks_two;
        color = Colors.grey[400]!;
        break;
      case 2:
        icon = Icons.looks_3;
        color = Colors.brown[300]!;
        break;
      default:
        icon = Icons.emoji_events;
        color = Colors.blue[300]!;
    }
    return Icon(icon, color: color, size: 32);
  }
}
