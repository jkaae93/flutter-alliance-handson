import '../entities/counter_history.dart';

abstract class HistoryRepository {
  Future<List<CounterHistory>> getHistory();
  Future<void> addHistoryEntry(CounterHistory entry);
  Future<void> clearHistory();
}