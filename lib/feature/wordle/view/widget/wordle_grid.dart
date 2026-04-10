part of '../wordle_view.dart';

class _WordleGrid extends StatefulWidget {
  const _WordleGrid({
    required this.shakeAnimation,
    required this.scaleAnimation,
  });

  final Animation<double> shakeAnimation;
  final Animation<double> scaleAnimation;

  @override
  State<_WordleGrid> createState() => _WordleGridState();
}

class _WordleGridState extends State<_WordleGrid> {
  final GlobalKey _currentRowKey = GlobalKey();
  double _lastBottomInset = -1;

  void _scrollToCurrentRow() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_currentRowKey.currentContext != null) {
        Scrollable.ensureVisible(
          _currentRowKey.currentContext!,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.5,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    if (_lastBottomInset != bottomInset) {
      _lastBottomInset = bottomInset;
      if (bottomInset > 0) {
        _scrollToCurrentRow();
      }
    }

    return BlocConsumer<WordleViewModel, WordleState>(
      listenWhen: (previous, current) =>
          previous.attempts.length != current.attempts.length,
      listener: (context, state) {
        _scrollToCurrentRow();
      },
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
                    key: isCurrentRow ? _currentRowKey : null,
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
                      animation: widget.shakeAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(widget.shakeAnimation.value, 0),
                          child: ScaleTransition(
                            scale: widget.scaleAnimation,
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
          : context.colorScheme.outline,
      width: 2,
    );

    switch (status) {
      case LetterStatus.initial:
        if (letter.isNotEmpty) {
          border = Border.all(color: context.colorScheme.primary, width: 2);
        }
      case LetterStatus.absent:
        color = context.colorScheme.surfaceContainerHighest;
        textColor = context.colorScheme.onSurfaceVariant;
        border = Border.all(color: Colors.transparent);
      case LetterStatus.present:
        color = context.colorScheme.tertiaryContainer;
        textColor = context.colorScheme.onTertiaryContainer;
        border = Border.all(color: Colors.transparent);
      case LetterStatus.correct:
        color = context.colorScheme.primaryContainer;
        textColor = context.colorScheme.onPrimaryContainer;
        border = Border.all(color: Colors.transparent);
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
