import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

mixin InnerEvents<Event, State> on BlocBase<State> {
  final _innerEventController = StreamController<Event>.broadcast();
  Stream<Event> get innerEvents => _innerEventController.stream;

  void addInner(Event event) {
    _innerEventController.add(event);
  }

  @override
  Future<void> close() async {
    _innerEventController.close();

    await super.close();
  }
}
