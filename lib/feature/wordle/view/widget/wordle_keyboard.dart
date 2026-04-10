part of '../wordle_view.dart';

class _WordleKeyboard extends StatelessWidget {
  const _WordleKeyboard();

  String _getAlphabet(String lang) {
     if (lang == 'tr') return 'PQRSŞTUÜVWXYZABCÇDEFGĞHIİJKLMNOÖ';
     return 'QWERTYUIOPASDFGHJKLZXCVBNM';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordleViewModel, WordleState>(
      builder: (context, state) {
        final alphabet = _getAlphabet(state.lang);
        final rows = [
          alphabet.substring(0, alphabet.length ~/ 3),
          alphabet.substring(alphabet.length ~/ 3, (alphabet.length ~/ 3) * 2),
          alphabet.substring((alphabet.length ~/ 3) * 2),
        ];

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var row in rows)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var char in row.split(''))
                    _KeyCell(
                      char: char,
                      status: _getLetterStatus(char, state.attempts),
                      onTap: () => context.read<WordleViewModel>().addLetter(char),
                    ),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SpecialKey(icon: Icons.backspace, onTap: () => context.read<WordleViewModel>().removeLetter()),
                const SizedBox(width: 8),
                _SpecialKey(label: 'ENTER', onTap: () => context.read<WordleViewModel>().submitGuess()),
              ],
            ),
          ],
        );
      },
    );
  }

  LetterStatus _getLetterStatus(String char, List<WordleRow> attempts) {
    LetterStatus finalStatus = LetterStatus.initial;
    for (var attempt in attempts) {
      for (var i = 0; i < attempt.word.length; i++) {
        if (attempt.word[i] == char) {
          final status = attempt.statuses[i];
          if (status == LetterStatus.correct) return LetterStatus.correct;
          if (status == LetterStatus.present) finalStatus = LetterStatus.present;
          if (status == LetterStatus.absent && finalStatus == LetterStatus.initial) finalStatus = LetterStatus.absent;
        }
      }
    }
    return finalStatus;
  }
}

class _KeyCell extends StatelessWidget {
  const _KeyCell({required this.char, required this.status, required this.onTap});

  final String char;
  final LetterStatus status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color color = context.colorScheme.surface.withValues(alpha: 0.8);
    Color textColor = context.colorScheme.onSurface;

    switch (status) {
      case LetterStatus.correct:
        color = Colors.green;
        textColor = Colors.white;
        break;
      case LetterStatus.present:
        color = Colors.orange;
        textColor = Colors.white;
        break;
      case LetterStatus.absent:
        color = Colors.grey[800]!;
        textColor = Colors.white;
        break;
      default:
        break;
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        width: (context.width - 60) / 10,
        height: 50,
        margin: const EdgeInsets.all(2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          char,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

class _SpecialKey extends StatelessWidget {
  const _SpecialKey({required this.onTap, this.icon, this.label});

  final IconData? icon;
  final String? label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: context.colorScheme.surface.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: icon != null
              ? Icon(icon, color: context.colorScheme.onSurface)
              : Text(
                  label!,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface,
                  ),
                ),
        ),
      ),
    );
  }
}
