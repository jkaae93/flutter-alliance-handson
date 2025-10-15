import 'package:flutter/foundation.dart';
import '../../../../core/usecase.dart';
import '../../domain/entities/counter.dart';
import '../../domain/usecases/get_counter.dart';
import '../../domain/usecases/increment_counter.dart';
import '../../../history/domain/entities/counter_history.dart';
import '../../../history/domain/usecases/add_history_entry.dart';

class CounterProvider with ChangeNotifier {
  final GetCounter getCounter;
  final IncrementCounter incrementCounter;
  final AddHistoryEntry addHistoryEntry;

  CounterProvider({
    required this.getCounter,
    required this.incrementCounter,
    required this.addHistoryEntry,
  });

  Counter? _counter;
  bool _isLoading = false;
  String? _errorMessage;

  Counter? get counter => _counter;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadCounter() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _counter = await getCounter(NoParams());
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> increment() async {
    try {
      _counter = await incrementCounter(NoParams());
      notifyListeners();
      
      final historyEntry = CounterHistory(
        counterValue: _counter!.value,
        timestamp: DateTime.now(),
      );
      await addHistoryEntry(historyEntry);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}

