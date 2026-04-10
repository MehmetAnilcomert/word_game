part of '../wordle_view.dart';

class _WordleGrid extends StatelessWidget {
  const _WordleGrid({
    required this.shakeAnimation,
    required this.scaleAnimation,
  });

  final Animation<double> shakeAnimation;
  final Animation<double> scaleAnimation;

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

                  final isCurrentRow = rowIdx == state.attempts.length;

                  Widget rowWidget = Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(state.wordLength, (colIdx) {
                      String letter = '';
                      LetterStatus status = LetterStatus.initial;

                      if (row != null) {
                        letter = row.word[colIdx];
                        status = row.statuses[colIdx];
                      } else if (isCurrentRow) {
                        if (colIdx < state.currentGuess.length) {
                          letter = state.currentGuess[colIdx];
                        }
                      }

                      return _GridCell(
                        letter: letter,
                        status: status,
                        length: state.wordLength,
                        isError: isCurrentRow &&
                            state.isError &&
                            colIdx >= state.currentGuess.length,
                      );
                    }),
                  );

                  if (isCurrentRow && state.isError) {
                    rowWidget = AnimatedBuilder(
                      animation: shakeAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(shakeAnimation.value, 0),
                          child: ScaleTransition(
                            scale: scaleAnimation,
                            child: child,
                          ),
                        );
                      },
                      child: rowWidget,
                    );
                  }

                  return rowWidget;
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
  const _GridCell({
    required this.letter,
    required this.status,
    required this.length,
    this.isError = false,
  });

  final String letter;
  final LetterStatus status;
  final int length;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final cellSize = (context.width - 100) / length;

    Color color = Colors.transparent;
    Color textColor = context.colorScheme.onSurface;
    Border border = Border.all(
      color: isError
          ? context.colorScheme.error
          : context.colorScheme.secondary.withValues(alpha: 0.5),
      width: isError ? 2 : 1,
    );

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
      width: cellSize.clamp(40.0, 60.0),
      height: cellSize.clamp(40.0, 60.0),
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
          fontSize: (cellSize.clamp(40.0, 60.0) * 0.5),
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
