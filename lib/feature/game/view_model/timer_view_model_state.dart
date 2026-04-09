/// Base class for all timer-related states.
abstract class TimerViewModelState {
  /// Initializes a [TimerViewModelState].
  const TimerViewModelState();
}

/// Initial state before the timer starts.
class TimerInitial extends TimerViewModelState {
  /// Initializes a [TimerInitial].
  const TimerInitial();
}

/// State representing a running timer.
class TimerRunning extends TimerViewModelState {
  /// Initializes a [TimerRunning] state.
  const TimerRunning({
    required this.remainingTime,
    required this.isFlashing,
    required this.isNearingEnd,
  });

  /// Seconds remaining in the timer.
  final int remainingTime;

  /// Whether the timer is in a flashing/critical state.
  final bool isFlashing;

  /// Whether the timer is nearing its completion.
  final bool isNearingEnd;
}

/// State representing that the timer has finished.
class TimerEnded extends TimerViewModelState {
  /// Initializes a [TimerEnded].
  const TimerEnded();
}
