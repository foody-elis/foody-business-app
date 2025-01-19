import 'package:foody_business_app/dto/request/weekday_info_request_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../utils/sitting_times_steps.dart';
import '../../utils/time_json_serializer.dart';

part '../mapper/request/weekday_info_update_request_dto.g.dart';

@JsonSerializable()
class WeekdayInfoUpdateRequestDto {
  const WeekdayInfoUpdateRequestDto({
    this.startLaunch,
    this.endLaunch,
    this.startDinner,
    this.endDinner,
    required this.sittingTimeStep,
  });

  factory WeekdayInfoUpdateRequestDto.fromJson(Map<String, dynamic> json) =>
      _$WeekdayInfoUpdateRequestDtoFromJson(json);

  @JsonKey(fromJson: timeFromJsonNullable, toJson: timeToJsonNullable)
  final DateTime? startLaunch;

  @JsonKey(fromJson: timeFromJsonNullable, toJson: timeToJsonNullable)
  final DateTime? endLaunch;

  @JsonKey(fromJson: timeFromJsonNullable, toJson: timeToJsonNullable)
  final DateTime? startDinner;

  @JsonKey(fromJson: timeFromJsonNullable, toJson: timeToJsonNullable)
  final DateTime? endDinner;

  final SittingTimeStep sittingTimeStep;

  Map<String, dynamic> toJson() => _$WeekdayInfoUpdateRequestDtoToJson(this);

  WeekdayInfoRequestDto toWeekdayInfoRequestDto({
    required int weekDay,
    required int restaurantId,
  }) =>
      WeekdayInfoRequestDto(
        startLaunch: startLaunch,
        endLaunch: endLaunch,
        startDinner: startDinner,
        endDinner: endDinner,
        sittingTimeStep: sittingTimeStep,
        weekDay: weekDay,
        restaurantId: restaurantId,
      );
}
