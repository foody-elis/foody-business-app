import 'package:foody_business_app/dto/request/user_update_request_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../utils/date_json_serializer.dart';

part '../mapper/request/user_registration_request_dto.g.dart';

@JsonSerializable()
class UserRegistrationRequestDto extends UserUpdateRequestDto {
  const UserRegistrationRequestDto({
    required this.email,
    required this.password,
    required super.name,
    required super.surname,
    required super.birthDate,
    required super.phoneNumber,
    required super.avatarBase64,
  });

  factory UserRegistrationRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UserRegistrationRequestDtoFromJson(json);

  final String email;
  final String password;

  Map<String, dynamic> toJson() => _$UserRegistrationRequestDtoToJson(this);
}
