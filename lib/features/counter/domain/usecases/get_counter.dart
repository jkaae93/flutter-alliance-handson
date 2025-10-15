import '../../../../core/usecase.dart';
import '../entities/counter.dart';
import '../repositories/counter_repository.dart';

class GetCounter implements UseCase<Future<Counter>, NoParams> {
  final CounterRepository repository;

  GetCounter(this.repository);

  @override
  Future<Counter> call(NoParams params) {
    return repository.getCounter();
  }
}