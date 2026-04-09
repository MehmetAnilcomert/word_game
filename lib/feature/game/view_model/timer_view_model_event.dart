/// Base class for all timer-related events.
abstract class TimerEvent {
  /// Initializes a [TimerEvent].
  const TimerEvent();
}

/// Event to start the game timer.
class StartTimerEvent extends TimerEvent {
  /// Initializes a [StartTimerEvent] with [endTime].
  const StartTimerEvent(this.endTime);

  /// The timestamp (in milliseconds since epoch) when the game should end.
  final int endTime;
}

/// Event to update the timer status.
class UpdateTimerEvent extends TimerEvent {
  /// Initializes an [UpdateTimerEvent].
  const UpdateTimerEvent({
    required this.remainingTime,
    required this.isFlashing,
    required this.isNearingEnd,
  });

  /// Seconds remaining until the game ends.
  final int remainingTime;

  /// Whether the timer should flash (indicating critical time).
  final bool isFlashing;

  /// Whether the game is nearing its end.
  final bool isNearingEnd;
}

/// Event fired when the timer reaches zero.
class EndTimerEvent extends TimerEvent {
  /// Initializes an [EndTimerEvent].
  const EndTimerEvent();
}
