import 'package:bloc_with_inner_events/bloc/counter_bloc.dart';
import 'package:bloc_with_inner_events/bloc/counter_events.dart';
import 'package:bloc_with_inner_events/extended_bloc_bluilder/extended_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExtendedBlocBuilder<CounterBloc, int, ICounterEvent>(
      eventRegister: (on) {
        on<ShowDialogEvent>((event) {
          print(event);
        });
        on<NavigateToPageEvent>((event) {
          print(event);
        });
        on<StartAnimationEvent>((event) {
          print(event);
        });
        on<ShowBottomSheetEvent>((event) {
          print(event);
        });
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Material App Bar'),
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(state.toString()),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () => context.read<CounterBloc>().add(DecrementEvent()),
                      child: const Text('-'),
                    ),
                    TextButton(
                      onPressed: () => context.read<CounterBloc>().add(IncrementEvent()),
                      child: const Text('+'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
