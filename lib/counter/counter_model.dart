import 'package:counter/counter/counter.dart';

class CounterModel extends Counter {
  const CounterModel(int value) : super(value);

  factory CounterModel.fromEntity(Counter counter) {
    return CounterModel(counter.value);
  }

  Counter toEntity() => Counter(value);
}

