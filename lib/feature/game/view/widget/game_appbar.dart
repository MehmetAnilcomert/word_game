part of '../game_view.dart';

class _GameAppBar extends StatelessWidget {
  const _GameAppBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) {
          String title = state is TimerRunning && state.isNearingEnd
              ? LocaleKeys.hurryUp.tr()
              : LocaleKeys.gameScreenTitle.tr();

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              state is TimerRunning && state.isNearingEnd
                  ? Row(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: context.colorScheme.onPrimary,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.warning_amber_rounded,
                          color: context.colorScheme.error,
                          size: 35,
                        ),
                      ],
                    )
                  : Text(
                      title,
                      style: TextStyle(
                        color: context.colorScheme.onPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
