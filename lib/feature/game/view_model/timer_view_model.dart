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

  void _onStartTimer(StartTimerEvent event, Emitter<TimerViewModelState> emit) {
    _timer?.cancel();

    // Sektör standardı: Başlatıldığı an ilk kontrolü beklemeden manuel olarak bir kere yap.
    _evaluateTick(event.endTime);

    // Sektör Standardı: Relative timer.tick yerine Absolute timestamp (UTC veya bitiş zamanından çıkarma) 
    // kullanmak gerekir. frame-drop, veya telefon ekranı kilitleyince timer drift yaşanmasını önler.
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isClosed) {
        timer.cancel();
        return;
      }
      _evaluateTick(event.endTime);
    });
  }

  void _evaluateTick(int endTime) {
    final currentRemainingSeconds =
        ((endTime - DateTime.now().millisecondsSinceEpoch) / 1000).floor();

    if (currentRemainingSeconds <= 0) {
      _timer?.cancel();
      if (!isClosed) {
        add(const EndTimerEvent());
      }
    } else {
      // Sektör Standardı: Azalma uyarıları odanın kurulma anından ziyade "sabit son XX saniye" şeklinde tasarlanır
      // Çünkü oyuna son 30 saniye kala giren oyuncu ile ilk baştan beri duran oyuncu farklı renk görmemelidir.
      final isFlashing = currentRemainingSeconds <= 10;
      final isNearingEnd = currentRemainingSeconds <= 30;

      if (!isClosed) {
        add(
          UpdateTimerEvent(
            remainingTime: currentRemainingSeconds,
            isFlashing: isFlashing,
            isNearingEnd: isNearingEnd,
          ),
        );
      }
    }
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
