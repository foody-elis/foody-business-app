import 'package:json_annotation/json_annotation.dart';

import '../../utils/time_json_serializer.dart';

part '../mapper/response/sitting_time_response_dto.g.dart';

@JsonSerializable()
class SittingTimeResponseDto {
  const SittingTimeResponseDto({
    required this.id,
    required this.start,
    required this.end,
    required this.weekDayInfoId,
  });

  factory SittingTimeResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SittingTimeResponseDtoFromJson(json);

  final int id;

  @JsonKey(fromJson: timeFromJson, toJson: timeToJson)
  final DateTime start;

  @JsonKey(fromJson: timeFromJson, toJson: timeToJson)
  final DateTime end;

  final int weekDayInfoId;

  Map<String, dynamic> toJson() => _$SittingTimeResponseDtoToJson(this);
}
