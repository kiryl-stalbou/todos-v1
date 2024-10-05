// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoDataImpl _$$TodoDataImplFromJson(Map<String, dynamic> json) =>
    _$TodoDataImpl(
      id: json['id'] as String,
      title: json['title'] as String?,
      notes: json['notes'] as String?,
      date: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['date'], const _TimestampSerializer().fromJson),
      isCompleted: json['isCompleted'] as bool,
    );

Map<String, dynamic> _$$TodoDataImplToJson(_$TodoDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'notes': instance.notes,
      'date': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.date, const _TimestampSerializer().toJson),
      'isCompleted': instance.isCompleted,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
