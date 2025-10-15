import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase.dart';
import '../../domain/entities/counter.dart';
import '../../domain/usecases/get_counter.dart';
import '../../domain/usecases/increment_counter.dart';
import '../../../history/domain/entities/counter_history.dart';
import '../../../history/domain/usecases/add_history_entry.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final GetCounter getCounter;
  final IncrementCounter incrementCounter;
  final AddHistoryEntry addHistoryEntry;

  CounterBloc({
    required this.getCounter,
    required this.incrementCounter,
    required this.addHistoryEntry,
  }) : super(CounterInitial()) {
    on<CounterStarted>(_onCounterStarted);
    on<CounterIncremented>(_onCounterIncremented);
  }

  Future<void> _onCounterStarted(
    CounterStarted event,
    Emitter<CounterState> emit,
  ) async {
    emit(CounterLoading());
    try {
      final counter = await getCounter(NoParams());
      emit(CounterLoaded(counter));
    } catch (e) {
      emit(CounterError(e.toString()));
    }
  }

  Future<void> _onCounterIncremented(
    CounterIncremented event,
    Emitter<CounterState> emit,
  ) async {
    try {
      final counter = await incrementCounter(NoParams());
      emit(CounterLoaded(counter));
      
      // 히스토리에 추가
      final historyEntry = CounterHistory(
        counterValue: counter.value,
        timestamp: DateTime.now(),
      );
      await addHistoryEntry(historyEntry);
    } catch (e) {
      emit(CounterError(e.toString()));
    }
  }
}