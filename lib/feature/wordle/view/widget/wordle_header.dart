part of '../wordle_view.dart';

class _WordleHeader extends StatelessWidget {
  const _WordleHeader({required this.showInfo, required this.scoreScaleAnimation});
  
  final VoidCallback showInfo;
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
            IconButton(
              onPressed: showInfo,
              icon: Icon(Icons.help_outline, color: context.colorScheme.onPrimary, size: 30),
            ),
          ],
        );
      },
    );
  }
}
