import 'package:counter/counter/counter.dart';
import 'package:counter/counter/counter_local_datasource.dart';
import 'package:counter/counter/counter_repository.dart';

class CounterRepositoryImpl implements CounterRepository {
  final CounterLocalDataSource dataSource;

  CounterRepositoryImpl(this.dataSource);

  @override
  Counter getCounter() => dataSource.getCounter();

  @override
  Counter increment() => dataSource.increment();
}

