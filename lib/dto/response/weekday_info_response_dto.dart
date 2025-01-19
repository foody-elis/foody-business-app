import 'package:foody_business_app/utils/sitting_times_steps.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../utils/time_json_serializer.dart';

part '../mapper/response/weekday_info_response_dto.g.dart';

@JsonSerializable()
class WeekdayInfoResponseDto {
  const WeekdayInfoResponseDto({
    required this.id,
    required this.weekDay,
    this.startLaunch,
    this.endLaunch,
    this.startDinner,
    this.endDinner,
    required this.sittingTimeStep,
    required this.restaurantId,
  });

  factory WeekdayInfoResponseDto.fromJson(Map<String, dynamic> json) =>
      _$WeekdayInfoResponseDtoFromJson(json);

  final int id;
  final int weekDay;

  @JsonKey(fromJson: timeFromJsonNullable, toJson: timeToJsonNullable)
  final DateTime? startLaunch;

  @JsonKey(fromJson: timeFromJsonNullable, toJson: timeToJsonNullable)
  final DateTime? endLaunch;

  @JsonKey(fromJson: timeFromJsonNullable, toJson: timeToJsonNullable)
  final DateTime? startDinner;

  @JsonKey(fromJson: timeFromJsonNullable, toJson: timeToJsonNullable)
  final DateTime? endDinner;

  final SittingTimeStep sittingTimeStep;

  final int restaurantId;

  Map<String, dynamic> toJson() => _$WeekdayInfoResponseDtoToJson(this);
}
