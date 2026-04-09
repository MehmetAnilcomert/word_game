abstract class TimerViewModelState {}

class TimerInitial extends TimerViewModelState {}

class TimerRunning extends TimerViewModelState {
  final int remainingTime;
  final bool isFlashing;
  final bool isNearingEnd;

  TimerRunning({
    required this.remainingTime,
    required this.isFlashing,
    required this.isNearingEnd,
  });
}

class TimerEnded extends TimerViewModelState {}
