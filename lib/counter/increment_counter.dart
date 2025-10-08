import 'package:counter/usecase.dart';
import 'package:counter/counter/counter.dart';
import 'package:counter/counter/counter_repository.dart';

class IncrementCounter implements UseCase<Counter, NoParams> {
  final CounterRepository repository;

  IncrementCounter(this.repository);

  @override
  Counter call(NoParams params) {
    return repository.increment();
  }
}

