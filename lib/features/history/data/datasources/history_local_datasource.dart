import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/counter_history_model.dart';

abstract class HistoryLocalDataSource {
  Future<List<CounterHistoryModel>> getHistory();
  Future<void> saveHistory(List<CounterHistoryModel> history);
}

class HistoryLocalDataSourceImpl implements HistoryLocalDataSource {
  static const String _historyKey = 'counter_history';
  final FlutterSecureStorage _secureStorage;

  HistoryLocalDataSourceImpl(this._secureStorage);

  @override
  Future<List<CounterHistoryModel>> getHistory() async {
    try {
      final historyJson = await _secureStorage.read(key: _historyKey);
      if (historyJson == null) return [];

      final List<dynamic> historyList = json.decode(historyJson);
      return historyList
          .map((item) => CounterHistoryModel.fromJson(item))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> saveHistory(List<CounterHistoryModel> history) async {
    final historyJson = json.encode(history.map((h) => h.toJson()).toList());
    await _secureStorage.write(key: _historyKey, value: historyJson);
  }
}