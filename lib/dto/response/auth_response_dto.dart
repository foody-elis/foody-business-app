import 'package:json_annotation/json_annotation.dart';

part '../mapper/response/auth_response_dto.g.dart';

@JsonSerializable()
class AuthResponseDto {
  const AuthResponseDto({required this.accessToken});

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseDtoFromJson(json);

  final String accessToken;

  Map<String, dynamic> toJson() => _$AuthResponseDtoToJson(this);
}
