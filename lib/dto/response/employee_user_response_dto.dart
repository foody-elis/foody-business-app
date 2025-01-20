import 'package:foody_business_app/dto/response/user_response_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../utils/roles.dart';

part '../mapper/response/employee_user_response_dto.g.dart';

@JsonSerializable()
class EmployeeUserResponseDto extends UserResponseDto {
  const EmployeeUserResponseDto({
    required super.id,
    required super.email,
    required super.name,
    required super.surname,
    required super.birthDate,
    required super.phoneNumber,
    required super.avatarUrl,
    required super.role,
    required super.active,
    required super.firebaseCustomToken,
    required this.employerRestaurantId,
  });

  factory EmployeeUserResponseDto.fromJson(Map<String, dynamic> json) =>
      _$EmployeeUserResponseDtoFromJson(json);

  final int employerRestaurantId;

  Map<String, dynamic> toJson() => _$EmployeeUserResponseDtoToJson(this);
}
