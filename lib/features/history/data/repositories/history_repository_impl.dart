import '../../domain/entities/counter_history.dart';
import '../../domain/repositories/history_repository.dart';
import '../datasources/history_local_datasource.dart';
import '../models/counter_history_model.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryLocalDataSource dataSource;

  HistoryRepositoryImpl(this.dataSource);

  @override
  Future<List<CounterHistory>> getHistory() async {
    final models = await dataSource.getHistory();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addHistoryEntry(CounterHistory entry) async {
    final currentHistory = await dataSource.getHistory();
    final newEntry = CounterHistoryModel.fromEntity(entry);
    final updatedHistory = [...currentHistory, newEntry];
    await dataSource.saveHistory(updatedHistory);
  }

  @override
  Future<void> clearHistory() async {
    await dataSource.saveHistory([]);
  }
}