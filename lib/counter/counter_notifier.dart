import 'package:flutter/material.dart';
import 'package:counter/counter/counter.dart';
import 'package:counter/counter/increment_counter.dart';
import 'package:counter/usecase.dart';

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

