import '../../../../core/usecase.dart';
import '../entities/counter_history.dart';
import '../repositories/counter_history_repository.dart';

class AddCounterHistory implements UseCase<Future<void>, CounterHistory> {
  final CounterHistoryRepository repository;

  AddCounterHistory(this.repository);

  @override
  Future<void> call(CounterHistory params) {
    return repository.addHistory(params);
  }
}
