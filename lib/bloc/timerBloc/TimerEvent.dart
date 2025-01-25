abstract class TimerEvent {}

class StartTimer extends TimerEvent {
  final int endTime;
  StartTimer(this.endTime);
}

class UpdateTimer extends TimerEvent {
  final int remainingTime;
  final bool isFlashing;
  final bool isNearingEnd;

  UpdateTimer(
      {required this.remainingTime,
      this.isFlashing = false,
      this.isNearingEnd = false});
}

class EndTimer extends TimerEvent {}
