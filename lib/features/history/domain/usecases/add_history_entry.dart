import '../../../../core/usecase.dart';
import '../entities/counter_history.dart';
import '../repositories/history_repository.dart';

class AddHistoryEntry implements UseCase<Future<void>, CounterHistory> {
  final HistoryRepository repository;

  AddHistoryEntry(this.repository);

  @override
  Future<void> call(CounterHistory params) {
    return repository.addHistoryEntry(params);
  }
}