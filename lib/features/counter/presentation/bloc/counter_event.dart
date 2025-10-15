import 'package:equatable/equatable.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object?> get props => [];
}

class IncrementCounterEvent extends CounterEvent {
  const IncrementCounterEvent();
}

class GetCounterEvent extends CounterEvent {
  const GetCounterEvent();
}
