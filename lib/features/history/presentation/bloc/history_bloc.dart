import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase.dart';
import '../../domain/usecases/get_history.dart';
import 'history_event.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetHistory getHistory;

  HistoryBloc({
    required this.getHistory,
  }) : super(HistoryInitial()) {
    on<HistoryStarted>(_onHistoryStarted);
    on<HistoryRefreshed>(_onHistoryRefreshed);
  }

  Future<void> _onHistoryStarted(
    HistoryStarted event,
    Emitter<HistoryState> emit,
  ) async {
    emit(HistoryLoading());
    try {
      final history = await getHistory(NoParams());
      emit(HistoryLoaded(history));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }

  Future<void> _onHistoryRefreshed(
    HistoryRefreshed event,
    Emitter<HistoryState> emit,
  ) async {
    try {
      final history = await getHistory(NoParams());
      emit(HistoryLoaded(history));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }
}