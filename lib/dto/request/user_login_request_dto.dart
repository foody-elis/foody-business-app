import 'package:json_annotation/json_annotation.dart';

part '../mapper/request/user_login_request_dto.g.dart';

@JsonSerializable()
class UserLoginRequestDto {
  const UserLoginRequestDto({required this.email, required this.password});

  factory UserLoginRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UserLoginRequestDtoFromJson(json);

  final String email;
  final String password;

  Map<String, dynamic> toJson() => _$UserLoginRequestDtoToJson(this);
}
