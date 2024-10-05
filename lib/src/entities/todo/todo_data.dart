import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_data.freezed.dart';
part 'todo_data.g.dart';

@Freezed(fromJson: true, toJson: true, copyWith: true)
class TodoData with _$TodoData {
  const factory TodoData({
    required String id,
    required String? title,
    required String? notes,
    @_TimestampSerializer() required DateTime? date,
    required bool isCompleted,
  }) = _TodoData;

  const TodoData._();

  factory TodoData.fromJson(Map<String, Object?> json) => _$TodoDataFromJson(json);
}

class _TimestampSerializer implements JsonConverter<DateTime, Timestamp> {
  const _TimestampSerializer();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
