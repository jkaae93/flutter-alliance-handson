import 'package:flutter/foundation.dart';
import '../../../../core/usecase.dart';
import '../../domain/entities/counter_history.dart';
import '../../domain/usecases/get_history.dart';

class HistoryProvider with ChangeNotifier {
  final GetHistory getHistory;

  HistoryProvider({
    required this.getHistory,
  });

  List<CounterHistory> _history = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<CounterHistory> get history => _history;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadHistory() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _history = await getHistory(NoParams());
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    try {
      _history = await getHistory(NoParams());
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}

