import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_member.freezed.dart';
part 'staff_member.g.dart';

enum StaffRole {
  owner,
  manager,
  cashier,
}

@freezed
class StaffMember with _$StaffMember {
  const factory StaffMember({
    required String id,
    required String name,
    required String phoneNumber,
    required String email,
    required StaffRole role,
    required bool isActive,
    required DateTime createdAt,
    required DateTime lastLoginAt,
    String? createdBy, // ID of the staff member who created this account
    String? notes,
  }) = _StaffMember;

  factory StaffMember.fromJson(Map<String, dynamic> json) =>
      _$StaffMemberFromJson(json);
}
