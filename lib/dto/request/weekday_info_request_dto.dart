import 'package:foody_business_app/dto/request/weekday_info_update_request_dto.dart';
import 'package:foody_business_app/utils/sitting_times_steps.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../utils/time_json_serializer.dart';

part '../mapper/request/weekday_info_request_dto.g.dart';

@JsonSerializable()
class WeekdayInfoRequestDto extends WeekdayInfoUpdateRequestDto {
  const WeekdayInfoRequestDto({
    super.startLaunch,
    super.endLaunch,
    super.startDinner,
    super.endDinner,
    required super.sittingTimeStep,
    required this.weekDay,
    required this.restaurantId,
  });

  factory WeekdayInfoRequestDto.fromJson(Map<String, dynamic> json) =>
      _$WeekdayInfoRequestDtoFromJson(json);

  final int weekDay;
  final int restaurantId;

  Map<String, dynamic> toJson() => _$WeekdayInfoRequestDtoToJson(this);
}
