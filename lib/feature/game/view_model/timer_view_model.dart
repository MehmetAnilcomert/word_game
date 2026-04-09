import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/feature/game/view_model/timer_view_model_event.dart';
import 'package:word_game/feature/game/view_model/timer_view_model_state.dart';

/// [TimerViewModel] manages the countdown timer logic for the game.
/// It tracks the remaining time and emits status updates periodically.
class TimerViewModel extends Bloc<TimerEvent, TimerViewModelState> {
  /// Initializes the [TimerViewModel] with [TimerInitial].
  TimerViewModel() : super(const TimerInitial()) {
    on<StartTimerEvent>(_onStartTimer);
    on<UpdateTimerEvent>(_onUpdateTimer);
    on<EndTimerEvent>(_onEndTimer);
  }

  Timer? _timer;
  late int? _totalGameTime;

  void _onStartTimer(StartTimerEvent event, Emitter<TimerViewModelState> emit) {
    _timer?.cancel();

    _totalGameTime =
        ((event.endTime - DateTime.now().millisecondsSinceEpoch) / 1000)
            .floor();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isClosed) {
        timer.cancel();
        return;
      }

      final currentRemainingSeconds = _totalGameTime! - timer.tick;

      if (currentRemainingSeconds <= 0) {
        timer.cancel();
        add(const EndTimerEvent());
      } else {
        final warningThreshold = _totalGameTime! ~/ 2;
        final isFlashing = currentRemainingSeconds <= 10;
        final isNearingEnd = currentRemainingSeconds <= warningThreshold;

        add(UpdateTimerEvent(
          remainingTime: currentRemainingSeconds,
          isFlashing: isFlashing,
          isNearingEnd: isNearingEnd,
        ),);
      }
    });
  }

  void _onUpdateTimer(
      UpdateTimerEvent event, Emitter<TimerViewModelState> emit,) {
    emit(TimerRunning(
      remainingTime: event.remainingTime,
      isFlashing: event.isFlashing,
      isNearingEnd: event.isNearingEnd,
    ),);
  }

  void _onEndTimer(EndTimerEvent event, Emitter<TimerViewModelState> emit) {
    _timer?.cancel();
    emit(const TimerEnded());
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
