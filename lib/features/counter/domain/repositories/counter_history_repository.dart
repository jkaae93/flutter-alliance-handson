import '../entities/counter_history.dart';

abstract class CounterHistoryRepository {
  Future<List<CounterHistory>> getHistory();
  Future<void> addHistory(CounterHistory history);
  Future<void> clearHistory();
}
