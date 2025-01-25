import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/bloc/timerBloc/TimerEvent.dart';
import 'package:word_game/bloc/timerBloc/TimerState.dart';
import 'dart:async';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  Timer? _timer;
  int? _totalGameTime;
  late int _endTime;

  TimerBloc() : super(TimerInitial()) {
    on<StartTimer>((event, emit) {
      _timer?.cancel();

      // Calculate total game time and end time.
      _endTime = event.endTime;
      _totalGameTime =
          ((_endTime - DateTime.now().millisecondsSinceEpoch) / 1000).floor();

      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (isClosed) {
          timer.cancel();
          return;
        }

        final currentRemainingSeconds = _totalGameTime! - timer.tick;

        if (currentRemainingSeconds <= 0) {
          timer.cancel();
          add(EndTimer());
        } else {
          final warningThreshold = (_totalGameTime! ~/ 3).floor();
          final isFlashing = currentRemainingSeconds <= 10;
          final isNearingEnd = currentRemainingSeconds <= warningThreshold;

          if (state is! TimerRunning ||
              (state as TimerRunning).remainingTime !=
                  currentRemainingSeconds) {
            add(UpdateTimer(
              remainingTime: currentRemainingSeconds,
              isFlashing: isFlashing,
              isNearingEnd: isNearingEnd,
            ));
          }
        }
      });
    });

    on<UpdateTimer>((event, emit) {
      if (!isClosed) {
        emit(TimerRunning(
          remainingTime: event.remainingTime,
          isFlashing: event.isFlashing,
          isNearingEnd: event.isNearingEnd,
        ));
      }
    });

    on<EndTimer>((event, emit) {
      _timer?.cancel();
      emit(TimerEnded());
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _totalGameTime = null;
    return super.close();
  }
}
