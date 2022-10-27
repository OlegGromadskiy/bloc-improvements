import 'dart:async';

import 'package:bloc_with_inner_events/bloc_with_inner_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef InnerEventHandler<T> = void Function(T event);
typedef OnFunction<E> = void Function<T extends E>(InnerEventHandler<T>);
typedef EventRegister<E> = void Function(OnFunction<E> on);

class ExtendedBlocBuilder<B extends InnerEvents<E, S>, S, E> extends StatefulWidget {
  final B? bloc;
  final BlocWidgetBuilder<S> builder;
  final EventRegister<E>? eventRegister;
  final BlocBuilderCondition<S>? buildWhen;

  const ExtendedBlocBuilder({
    Key? key,
    this.bloc,
    this.buildWhen,
    this.eventRegister,
    required this.builder,
  }) : super(key: key);

  @override
  _ExtendedBlocBuilderState createState() => _ExtendedBlocBuilderState<B, S, E>();
}

class _ExtendedBlocBuilderState<B extends InnerEvents<E, S>, S, E>
    extends State<ExtendedBlocBuilder<B, S, E>> {
  late B bloc;
  late StreamSubscription<E> subscription;
  final _handlers = <Type, InnerEventHandler<E>>{};

  @override
  void initState() {
    super.initState();
    bloc = widget.bloc ?? context.read<B>();
    subscription = bloc.innerEvents.listen((event) {
      _handlers[event.runtimeType]?.call(event);
    });

    widget.eventRegister?.call(onInner);
  }

  void onInner<T extends E>(InnerEventHandler<T> handler) {
    _handlers[T] = (E event) => handler(event as T);
  }

  @override
  void didUpdateWidget(ExtendedBlocBuilder<B, S, E> old) {
    super.didUpdateWidget(old);

    final oldBloc = old.bloc ?? context.read<B>();
    final currentBloc = widget.bloc ?? oldBloc;
    if (oldBloc != currentBloc) {
      bloc = currentBloc;
    }
  }

  @override
  void dispose() {
    subscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: widget.builder,
      buildWhen: widget.buildWhen,
      bloc: bloc,
    );
  }
}
