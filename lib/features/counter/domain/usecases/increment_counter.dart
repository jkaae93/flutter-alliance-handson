import '../../../../core/usecase.dart';
import '../entities/counter.dart';
import '../repositories/counter_repository.dart';

class IncrementCounter implements UseCase<Counter, NoParams> {
  final CounterRepository repository;

  IncrementCounter(this.repository);

  @override
  Counter call(NoParams params) {
    return repository.increment();
  }
}