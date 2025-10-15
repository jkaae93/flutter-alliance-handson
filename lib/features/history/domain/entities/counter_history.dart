import 'package:equatable/equatable.dart';

class CounterHistory extends Equatable {
  final int counterValue;
  final DateTime timestamp;

  const CounterHistory({
    required this.counterValue,
    required this.timestamp,
  });

  @override
  List<Object> get props => [counterValue, timestamp];
}