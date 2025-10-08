import 'package:counter/counter/counter_model.dart';

abstract class CounterLocalDataSource {
  CounterModel getCounter();
  CounterModel increment();
}

class CounterLocalDataSourceImpl implements CounterLocalDataSource {
  CounterModel _counter = const CounterModel(0);

  @override
  CounterModel getCounter() => _counter;

  @override
  CounterModel increment() {
    _counter = CounterModel(_counter.value + 1);
    return _counter;
  }
}

