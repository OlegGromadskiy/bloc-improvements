import 'dart:async';

import 'package:bloc_with_inner_events/bloc_with_inner_events.dart';
import 'package:bloc_with_inner_events/bloc/counter_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<ICounterEvent, int> with InnerEvents<ICounterEvent, int> {
  CounterBloc() : super(0) {
    on<IncrementEvent>(_increment);
    on<DecrementEvent>(_decrement);
  }

  FutureOr<void> _increment(IncrementEvent event, Emitter emit) {
    emit(state + 1);
    if (state == 5) {
      addInner(ShowDialogEvent());
    } else if (state == 10) {
      addInner(NavigateToPageEvent());
    }
  }

  FutureOr<void> _decrement(DecrementEvent event, Emitter emit) {
    emit(state - 1);

    if (state == -5) {
      addInner(ShowBottomSheetEvent());
    } else if (state == -10) {
      addInner(StartAnimationEvent());
    }
  }
}
