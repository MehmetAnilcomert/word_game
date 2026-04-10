part of '../wordle_view.dart';

class _WordleGrid extends StatelessWidget {
  const _WordleGrid();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordleViewModel, WordleState>(
      builder: (context, state) {
        return Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(6, (rowIdx) {
                  WordleRow? row;
                  if (rowIdx < state.attempts.length) {
                    row = state.attempts[rowIdx];
                  }
                  
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(state.wordLength, (colIdx) {
                      String letter = '';
                      LetterStatus status = LetterStatus.initial;
                      
                      if (row != null) {
                        letter = row.word[colIdx];
                        status = row.statuses[colIdx];
                      } else if (rowIdx == state.attempts.length) {
                        if (colIdx < state.currentGuess.length) {
                          letter = state.currentGuess[colIdx];
                        }
                      }
                      
                      return _GridCell(letter: letter, status: status, length: state.wordLength);
                    }),
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GridCell extends StatelessWidget {
  const _GridCell({required this.letter, required this.status, required this.length});

  final String letter;
  final LetterStatus status;
  final int length;

  @override
  Widget build(BuildContext context) {
    final cellSize = (context.width - 100) / length;
    
    Color color = Colors.transparent;
    Color textColor = context.colorScheme.onSurface;
    Border border = Border.all(color: context.colorScheme.secondary.withValues(alpha: 0.5));
    
    switch (status) {
      case LetterStatus.initial:
        if (letter.isNotEmpty) {
           border = Border.all(color: context.colorScheme.primary, width: 2);
        }
        break;
      case LetterStatus.absent:
        color = Colors.grey[700]!;
        textColor = Colors.white;
        border = Border.all(color: Colors.transparent);
        break;
      case LetterStatus.present:
        color = Colors.orange;
        textColor = Colors.white;
        border = Border.all(color: Colors.transparent);
        break;
      case LetterStatus.correct:
        color = Colors.green;
        textColor = Colors.white;
        border = Border.all(color: Colors.transparent);
        break;
    }

    return Container(
      width: cellSize.clamp(40, 60),
      height: cellSize.clamp(40, 60),
      margin: const EdgeInsets.all(4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        border: border,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        letter,
        style: TextStyle(
          fontSize: cellSize.clamp(40, 60) * 0.5,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
