import 'package:flutter/material.dart';

import '../../domain/entities/counter.dart';
import '../../domain/usecases/increment_counter.dart';
import '../../../../core/usecase.dart';

class CounterNotifier extends ChangeNotifier {
  Counter _counter = const Counter(0);
  Counter get counter => _counter;

  final IncrementCounter incrementCounter;

  CounterNotifier(this.incrementCounter);

  void increment() {
    _counter = incrementCounter(NoParams());
    notifyListeners();
  }
}