// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TodoData _$TodoDataFromJson(Map<String, dynamic> json) {
  return _TodoData.fromJson(json);
}

/// @nodoc
mixin _$TodoData {
  String get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @_TimestampSerializer()
  DateTime? get date => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoDataCopyWith<TodoData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoDataCopyWith<$Res> {
  factory $TodoDataCopyWith(TodoData value, $Res Function(TodoData) then) =
      _$TodoDataCopyWithImpl<$Res, TodoData>;
  @useResult
  $Res call(
      {String id,
      String? title,
      String? notes,
      @_TimestampSerializer() DateTime? date,
      bool isCompleted});
}

/// @nodoc
class _$TodoDataCopyWithImpl<$Res, $Val extends TodoData>
    implements $TodoDataCopyWith<$Res> {
  _$TodoDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? notes = freezed,
    Object? date = freezed,
    Object? isCompleted = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodoDataImplCopyWith<$Res>
    implements $TodoDataCopyWith<$Res> {
  factory _$$TodoDataImplCopyWith(
          _$TodoDataImpl value, $Res Function(_$TodoDataImpl) then) =
      __$$TodoDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? title,
      String? notes,
      @_TimestampSerializer() DateTime? date,
      bool isCompleted});
}

/// @nodoc
class __$$TodoDataImplCopyWithImpl<$Res>
    extends _$TodoDataCopyWithImpl<$Res, _$TodoDataImpl>
    implements _$$TodoDataImplCopyWith<$Res> {
  __$$TodoDataImplCopyWithImpl(
      _$TodoDataImpl _value, $Res Function(_$TodoDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? notes = freezed,
    Object? date = freezed,
    Object? isCompleted = null,
  }) {
    return _then(_$TodoDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TodoDataImpl extends _TodoData {
  const _$TodoDataImpl(
      {required this.id,
      required this.title,
      required this.notes,
      @_TimestampSerializer() required this.date,
      required this.isCompleted})
      : super._();

  factory _$TodoDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoDataImplFromJson(json);

  @override
  final String id;
  @override
  final String? title;
  @override
  final String? notes;
  @override
  @_TimestampSerializer()
  final DateTime? date;
  @override
  final bool isCompleted;

  @override
  String toString() {
    return 'TodoData(id: $id, title: $title, notes: $notes, date: $date, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, notes, date, isCompleted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoDataImplCopyWith<_$TodoDataImpl> get copyWith =>
      __$$TodoDataImplCopyWithImpl<_$TodoDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoDataImplToJson(
      this,
    );
  }
}

abstract class _TodoData extends TodoData {
  const factory _TodoData(
      {required final String id,
      required final String? title,
      required final String? notes,
      @_TimestampSerializer() required final DateTime? date,
      required final bool isCompleted}) = _$TodoDataImpl;
  const _TodoData._() : super._();

  factory _TodoData.fromJson(Map<String, dynamic> json) =
      _$TodoDataImpl.fromJson;

  @override
  String get id;
  @override
  String? get title;
  @override
  String? get notes;
  @override
  @_TimestampSerializer()
  DateTime? get date;
  @override
  bool get isCompleted;
  @override
  @JsonKey(ignore: true)
  _$$TodoDataImplCopyWith<_$TodoDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
