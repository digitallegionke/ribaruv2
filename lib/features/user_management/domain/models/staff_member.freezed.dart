// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StaffMember _$StaffMemberFromJson(Map<String, dynamic> json) {
  return _StaffMember.fromJson(json);
}

/// @nodoc
mixin _$StaffMember {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  StaffRole get role => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get lastLoginAt => throw _privateConstructorUsedError;
  String? get createdBy =>
      throw _privateConstructorUsedError; // ID of the staff member who created this account
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this StaffMember to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StaffMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffMemberCopyWith<StaffMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffMemberCopyWith<$Res> {
  factory $StaffMemberCopyWith(
          StaffMember value, $Res Function(StaffMember) then) =
      _$StaffMemberCopyWithImpl<$Res, StaffMember>;
  @useResult
  $Res call(
      {String id,
      String name,
      String phoneNumber,
      String email,
      StaffRole role,
      bool isActive,
      DateTime createdAt,
      DateTime lastLoginAt,
      String? createdBy,
      String? notes});
}

/// @nodoc
class _$StaffMemberCopyWithImpl<$Res, $Val extends StaffMember>
    implements $StaffMemberCopyWith<$Res> {
  _$StaffMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phoneNumber = null,
    Object? email = null,
    Object? role = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? lastLoginAt = null,
    Object? createdBy = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as StaffRole,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastLoginAt: null == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StaffMemberImplCopyWith<$Res>
    implements $StaffMemberCopyWith<$Res> {
  factory _$$StaffMemberImplCopyWith(
          _$StaffMemberImpl value, $Res Function(_$StaffMemberImpl) then) =
      __$$StaffMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String phoneNumber,
      String email,
      StaffRole role,
      bool isActive,
      DateTime createdAt,
      DateTime lastLoginAt,
      String? createdBy,
      String? notes});
}

/// @nodoc
class __$$StaffMemberImplCopyWithImpl<$Res>
    extends _$StaffMemberCopyWithImpl<$Res, _$StaffMemberImpl>
    implements _$$StaffMemberImplCopyWith<$Res> {
  __$$StaffMemberImplCopyWithImpl(
      _$StaffMemberImpl _value, $Res Function(_$StaffMemberImpl) _then)
      : super(_value, _then);

  /// Create a copy of StaffMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phoneNumber = null,
    Object? email = null,
    Object? role = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? lastLoginAt = null,
    Object? createdBy = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$StaffMemberImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as StaffRole,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastLoginAt: null == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StaffMemberImpl implements _StaffMember {
  const _$StaffMemberImpl(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.email,
      required this.role,
      required this.isActive,
      required this.createdAt,
      required this.lastLoginAt,
      this.createdBy,
      this.notes});

  factory _$StaffMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaffMemberImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String phoneNumber;
  @override
  final String email;
  @override
  final StaffRole role;
  @override
  final bool isActive;
  @override
  final DateTime createdAt;
  @override
  final DateTime lastLoginAt;
  @override
  final String? createdBy;
// ID of the staff member who created this account
  @override
  final String? notes;

  @override
  String toString() {
    return 'StaffMember(id: $id, name: $name, phoneNumber: $phoneNumber, email: $email, role: $role, isActive: $isActive, createdAt: $createdAt, lastLoginAt: $lastLoginAt, createdBy: $createdBy, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffMemberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phoneNumber, email,
      role, isActive, createdAt, lastLoginAt, createdBy, notes);

  /// Create a copy of StaffMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffMemberImplCopyWith<_$StaffMemberImpl> get copyWith =>
      __$$StaffMemberImplCopyWithImpl<_$StaffMemberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StaffMemberImplToJson(
      this,
    );
  }
}

abstract class _StaffMember implements StaffMember {
  const factory _StaffMember(
      {required final String id,
      required final String name,
      required final String phoneNumber,
      required final String email,
      required final StaffRole role,
      required final bool isActive,
      required final DateTime createdAt,
      required final DateTime lastLoginAt,
      final String? createdBy,
      final String? notes}) = _$StaffMemberImpl;

  factory _StaffMember.fromJson(Map<String, dynamic> json) =
      _$StaffMemberImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get phoneNumber;
  @override
  String get email;
  @override
  StaffRole get role;
  @override
  bool get isActive;
  @override
  DateTime get createdAt;
  @override
  DateTime get lastLoginAt;
  @override
  String? get createdBy; // ID of the staff member who created this account
  @override
  String? get notes;

  /// Create a copy of StaffMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffMemberImplCopyWith<_$StaffMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
