import 'package:equatable/equatable.dart';

class CounterHistory extends Equatable {
  final int count;
  final DateTime timestamp;

  const CounterHistory({
    required this.count,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [count, timestamp];
}
