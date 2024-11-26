// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StaffMemberImpl _$$StaffMemberImplFromJson(Map<String, dynamic> json) =>
    _$StaffMemberImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      role: $enumDecode(_$StaffRoleEnumMap, json['role']),
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastLoginAt: DateTime.parse(json['lastLoginAt'] as String),
      createdBy: json['createdBy'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$StaffMemberImplToJson(_$StaffMemberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'role': _$StaffRoleEnumMap[instance.role]!,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastLoginAt': instance.lastLoginAt.toIso8601String(),
      'createdBy': instance.createdBy,
      'notes': instance.notes,
    };

const _$StaffRoleEnumMap = {
  StaffRole.owner: 'owner',
  StaffRole.manager: 'manager',
  StaffRole.cashier: 'cashier',
};
