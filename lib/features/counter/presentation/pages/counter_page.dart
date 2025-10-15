import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/counter_history.dart';
import '../bloc/counter_bloc.dart';
import '../bloc/counter_event.dart';
import '../bloc/counter_state.dart';
import '../bloc/history_bloc.dart';
import '../bloc/history_event.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            if (state is CounterLoaded) {
              return Text(
                '${state.counter.value}',
                style: Theme.of(context).textTheme.displayLarge,
              );
            }
            return const Text('0', style: TextStyle(fontSize: 48));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final currentState = context.read<CounterBloc>().state;
          if (currentState is CounterLoaded) {
            final newCount = currentState.counter.value + 1;
            context.read<HistoryBloc>().add(
              AddHistoryEvent(
                CounterHistory(
                  count: newCount,
                  timestamp: DateTime.now(),
                ),
              ),
            );
          } else {
            context.read<HistoryBloc>().add(
              AddHistoryEvent(
                CounterHistory(
                  count: 1,
                  timestamp: DateTime.now(),
                ),
              ),
            );
          }
          context.read<CounterBloc>().add(const IncrementCounterEvent());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
