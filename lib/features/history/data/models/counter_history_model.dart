import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/counter_history.dart';

part 'counter_history_model.g.dart';

@JsonSerializable()
class CounterHistoryModel extends CounterHistory {
  const CounterHistoryModel({
    required int counterValue,
    required DateTime timestamp,
  }) : super(counterValue: counterValue, timestamp: timestamp);

  factory CounterHistoryModel.fromEntity(CounterHistory history) {
    return CounterHistoryModel(
      counterValue: history.counterValue,
      timestamp: history.timestamp,
    );
  }

  factory CounterHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$CounterHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CounterHistoryModelToJson(this);

  CounterHistory toEntity() => CounterHistory(
        counterValue: counterValue,
        timestamp: timestamp,
      );
}