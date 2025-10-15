import '../../domain/entities/counter.dart';
import '../../domain/repositories/counter_repository.dart';
import '../datasources/counter_local_datasource.dart';

class CounterRepositoryImpl implements CounterRepository {
  final CounterLocalDataSource dataSource;

  CounterRepositoryImpl(this.dataSource);

  @override
  Future<Counter> getCounter() async {
    final model = await dataSource.getCounter();
    return model.toEntity();
  }

  @override
  Future<Counter> increment() async {
    final model = await dataSource.increment();
    return model.toEntity();
  }
}