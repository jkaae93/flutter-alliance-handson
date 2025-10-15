import '../../../../core/usecase.dart';
import '../entities/counter_history.dart';
import '../repositories/counter_history_repository.dart';

class GetCounterHistory implements UseCase<Future<List<CounterHistory>>, NoParams> {
  final CounterHistoryRepository repository;

  GetCounterHistory(this.repository);

  @override
  Future<List<CounterHistory>> call(NoParams params) {
    return repository.getHistory();
  }
}
