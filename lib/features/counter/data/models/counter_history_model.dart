import '../../domain/entities/counter_history.dart';

class CounterHistoryModel extends CounterHistory {
  const CounterHistoryModel({
    required super.count,
    required super.timestamp,
  });

  factory CounterHistoryModel.fromJson(Map<String, dynamic> json) {
    return CounterHistoryModel(
      count: json['count'] as int,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory CounterHistoryModel.fromEntity(CounterHistory history) {
    return CounterHistoryModel(
      count: history.count,
      timestamp: history.timestamp,
    );
  }

  CounterHistory toEntity() => CounterHistory(
    count: count,
    timestamp: timestamp,
  );
}
