// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CounterHistoryModel _$CounterHistoryModelFromJson(Map<String, dynamic> json) =>
    CounterHistoryModel(
      counterValue: json['counterValue'] as int,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$CounterHistoryModelToJson(
        CounterHistoryModel instance) =>
    <String, dynamic>{
      'counterValue': instance.counterValue,
      'timestamp': instance.timestamp.toIso8601String(),
    };