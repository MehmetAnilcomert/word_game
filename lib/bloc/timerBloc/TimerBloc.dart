import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/timerBloc/TimerEvent.dart';
import 'package:word_game/bloc/timerBloc/TimerState.dart';
import 'dart:async';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  Timer? _timer;
  int? _totalGameTime;

  TimerBloc() : super(TimerInitial()) {
    on<StartTimer>((event, emit) {
      _timer?.cancel();
      _totalGameTime =
          ((event.endTime - DateTime.now().millisecondsSinceEpoch) / 1000)
              .floor();

      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (isClosed) {
          timer.cancel();
          return;
        }

        final currentRemainingSeconds =
            ((event.endTime - DateTime.now().millisecondsSinceEpoch) / 1000)
                .floor();

        final warningThreshold = (_totalGameTime! ~/ 4).floor();

        if (currentRemainingSeconds <= 0) {
          timer.cancel();
          add(EndTimer());
        } else {
          add(UpdateTimer(
              remainingTime: currentRemainingSeconds,
              isFlashing: currentRemainingSeconds <= 10,
              isNearingEnd: currentRemainingSeconds <= warningThreshold));
        }
      });
    });

    on<UpdateTimer>((event, emit) {
      if (!isClosed) {
        emit(TimerRunning(
            remainingTime: event.remainingTime,
            isFlashing: event.isFlashing,
            isNearingEnd: event.isNearingEnd));
      }
    });

    on<EndTimer>((event, emit) {
      _timer?.cancel();
      emit(TimerEnded()); // Emit the TimerEnded state.
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
