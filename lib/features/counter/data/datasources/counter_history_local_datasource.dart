import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/counter_history_model.dart';

abstract class CounterHistoryLocalDataSource {
  Future<List<CounterHistoryModel>> getHistory();
  Future<void> addHistory(CounterHistoryModel history);
  Future<void> clearHistory();
}

class CounterHistoryLocalDataSourceImpl implements CounterHistoryLocalDataSource {
  final FlutterSecureStorage secureStorage;
  static const String _historyKey = 'counter_history';

  CounterHistoryLocalDataSourceImpl(this.secureStorage);

  @override
  Future<List<CounterHistoryModel>> getHistory() async {
    try {
      final String? historyJson = await secureStorage.read(key: _historyKey);
      if (historyJson == null || historyJson.isEmpty) {
        return [];
      }
      
      final List<dynamic> decoded = jsonDecode(historyJson);
      return decoded
          .map((item) => CounterHistoryModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> addHistory(CounterHistoryModel history) async {
    final List<CounterHistoryModel> currentHistory = await getHistory();
    currentHistory.add(history);
    
    final String encoded = jsonEncode(
      currentHistory.map((h) => h.toJson()).toList(),
    );
    
    await secureStorage.write(key: _historyKey, value: encoded);
  }

  @override
  Future<void> clearHistory() async {
    await secureStorage.delete(key: _historyKey);
  }
}
