import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase.dart';
import '../../domain/usecases/get_counter.dart';
import '../../domain/usecases/increment_counter.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final IncrementCounter incrementCounter;
  final GetCounter getCounter;

  CounterBloc({
    required this.incrementCounter,
    required this.getCounter,
  }) : super(const CounterInitial()) {
    on<GetCounterEvent>(_onGetCounter);
    on<IncrementCounterEvent>(_onIncrementCounter);
  }

  void _onGetCounter(GetCounterEvent event, Emitter<CounterState> emit) {
    final counter = getCounter(NoParams());
    emit(CounterLoaded(counter));
  }

  void _onIncrementCounter(IncrementCounterEvent event, Emitter<CounterState> emit) {
    final counter = incrementCounter(NoParams());
    emit(CounterLoaded(counter));
  }
}
