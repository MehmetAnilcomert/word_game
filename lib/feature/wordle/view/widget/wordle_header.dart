part of '../wordle_view.dart';

class _WordleHeader extends StatelessWidget {
  const _WordleHeader({required this.scoreScaleAnimation});

  final Animation<double> scoreScaleAnimation;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordleViewModel, WordleState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: context.colorScheme.surface.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(Icons.star, color: context.appColors.goldColor),
                  const SizedBox(width: 8),
                  ScaleTransition(
                    scale: scoreScaleAnimation,
                    child: Text(
                      state.totalScore.toString(),
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: PopupMenuButton<void>(
                offset: const Offset(0, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                color: context.colorScheme.surface,
                iconSize: 30,
                icon: Icon(
                  Icons.help_outline,
                  color: context.colorScheme.onSurface,
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem<void>(
                      enabled: false,
                      child: SizedBox(
                        width: context.width * 0.65,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.wordleInfoTitle.tr(),
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              LocaleKeys.wordleInfoDesc.tr(),
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.onSurface
                                    .withValues(alpha: 0.8),
                              ),
                            ),
                            const SizedBox(height: 16),
                            _InfoColorRow(
                              color: context.colorScheme.primaryContainer,
                              textColor: context.colorScheme.onPrimaryContainer,
                              text: LocaleKeys.wordleInfoCorrect.tr(),
                            ),
                            const SizedBox(height: 8),
                            _InfoColorRow(
                              color: context.colorScheme.tertiaryContainer,
                              textColor:
                                  context.colorScheme.onTertiaryContainer,
                              text: LocaleKeys.wordleInfoPresent.tr(),
                            ),
                            const SizedBox(height: 8),
                            _InfoColorRow(
                              color:
                                  context.colorScheme.surfaceContainerHighest,
                              textColor: context.colorScheme.onSurfaceVariant,
                              text: LocaleKeys.wordleInfoAbsent.tr(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _InfoColorRow extends StatelessWidget {
  const _InfoColorRow({
    required this.color,
    required this.textColor,
    required this.text,
  });

  final Color color;
  final Color textColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: context.colorScheme.onSurface.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Text(
            'A',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
