import 'package:equatable/equatable.dart';
import '../../domain/entities/counter_history.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadHistoryEvent extends HistoryEvent {
  const LoadHistoryEvent();
}

class AddHistoryEvent extends HistoryEvent {
  final CounterHistory history;

  const AddHistoryEvent(this.history);

  @override
  List<Object?> get props => [history];
}
