abstract class TimerState {}

class TimerInitial extends TimerState {}

class TimerRunning extends TimerState {
  final int remainingTime;
  final bool isFlashing;
  final bool isNearingEnd;

  TimerRunning(
      {required this.remainingTime,
      this.isFlashing = false,
      this.isNearingEnd = false});
}

class TimerEnded extends TimerState {}
