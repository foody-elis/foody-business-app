import 'package:json_annotation/json_annotation.dart';

import '../../utils/roles.dart';

part '../mapper/response/user_response_dto.g.dart';

@JsonSerializable()
class UserResponseDto {
  const UserResponseDto({
    required this.id,
    required this.email,
    required this.name,
    required this.surname,
    required this.birthDate,
    required this.phoneNumber,
    required this.avatarUrl,
    required this.role,
    required this.active,
    required this.firebaseCustomToken,
  });

  factory UserResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UserResponseDtoFromJson(json);

  final int id;
  final String email;
  final String name;
  final String surname;
  final DateTime birthDate;
  final String phoneNumber;
  final String? avatarUrl;
  final Role role;
  final bool active;
  final String? firebaseCustomToken;

  Map<String, dynamic> toJson() => _$UserResponseDtoToJson(this);
}
