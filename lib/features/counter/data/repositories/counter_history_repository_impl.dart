import '../../domain/entities/counter_history.dart';
import '../../domain/repositories/counter_history_repository.dart';
import '../datasources/counter_history_local_datasource.dart';
import '../models/counter_history_model.dart';

class CounterHistoryRepositoryImpl implements CounterHistoryRepository {
  final CounterHistoryLocalDataSource dataSource;

  CounterHistoryRepositoryImpl(this.dataSource);

  @override
  Future<List<CounterHistory>> getHistory() async {
    final List<CounterHistoryModel> models = await dataSource.getHistory();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addHistory(CounterHistory history) async {
    final model = CounterHistoryModel.fromEntity(history);
    await dataSource.addHistory(model);
  }

  @override
  Future<void> clearHistory() async {
    await dataSource.clearHistory();
  }
}
