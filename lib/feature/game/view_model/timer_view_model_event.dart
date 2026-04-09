abstract class TimerEvent {}

class StartTimerEvent extends TimerEvent {
  final int endTime;
  StartTimerEvent(this.endTime);
}

class UpdateTimerEvent extends TimerEvent {
  final int remainingTime;
  final bool isFlashing;
  final bool isNearingEnd;

  UpdateTimerEvent({
    required this.remainingTime,
    required this.isFlashing,
    required this.isNearingEnd,
  });
}

class EndTimerEvent extends TimerEvent {}
