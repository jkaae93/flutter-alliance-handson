import '../models/counter_model.dart';

abstract class CounterLocalDataSource {
  Future<CounterModel> getCounter();
  Future<CounterModel> increment();
}

class CounterLocalDataSourceImpl implements CounterLocalDataSource {
  CounterModel _counter = const CounterModel(0);

  @override
  Future<CounterModel> getCounter() async => _counter;

  @override
  Future<CounterModel> increment() async {
    _counter = CounterModel(_counter.value + 1);
    return _counter;
  }
}