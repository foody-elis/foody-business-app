import 'package:json_annotation/json_annotation.dart';

import '../../utils/date_json_serializer.dart';

part '../mapper/request/user_update_request_dto.g.dart';

@JsonSerializable()
class UserUpdateRequestDto {
  const UserUpdateRequestDto({
    required this.name,
    required this.surname,
    required this.birthDate,
    required this.phoneNumber,
    required this.avatarBase64,
  });

  factory UserUpdateRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateRequestDtoFromJson(json);

  final String name;
  final String surname;
  final String phoneNumber;
  final String? avatarBase64;

  @JsonKey(fromJson: dateFromJson, toJson: dateToJson)
  final DateTime birthDate;

  Map<String, dynamic> toJson() => _$UserUpdateRequestDtoToJson(this);
}
