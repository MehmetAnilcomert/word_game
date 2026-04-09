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
              ? 'hurryUp'.tr()
              : 'gameScreenTitle'.tr();

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              state is TimerRunning && state.isNearingEnd
                  ? Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.red,
                          size: 35,
                        ),
                      ],
                    ) // Hurry up Widget
                  : Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ), // Normal Widget style
                    ),
            ],
          );
        },
      ),
    );
  }
}
