import '../../../../core/usecase.dart';
import '../entities/counter_history.dart';
import '../repositories/history_repository.dart';

class GetHistory implements UseCase<Future<List<CounterHistory>>, NoParams> {
  final HistoryRepository repository;

  GetHistory(this.repository);

  @override
  Future<List<CounterHistory>> call(NoParams params) {
    return repository.getHistory();
  }
}