import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase.dart';
import '../../domain/usecases/add_counter_history.dart';
import '../../domain/usecases/get_counter_history.dart';
import 'history_event.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetCounterHistory getCounterHistory;
  final AddCounterHistory addCounterHistory;

  HistoryBloc({
    required this.getCounterHistory,
    required this.addCounterHistory,
  }) : super(const HistoryInitial()) {
    on<LoadHistoryEvent>(_onLoadHistory);
    on<AddHistoryEvent>(_onAddHistory);
  }

  Future<void> _onLoadHistory(
    LoadHistoryEvent event,
    Emitter<HistoryState> emit,
  ) async {
    try {
      emit(const HistoryLoading());
      final history = await getCounterHistory(NoParams());
      emit(HistoryLoaded(history));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }

  Future<void> _onAddHistory(
    AddHistoryEvent event,
    Emitter<HistoryState> emit,
  ) async {
    try {
      await addCounterHistory(event.history);
      final history = await getCounterHistory(NoParams());
      emit(HistoryLoaded(history));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }
}
