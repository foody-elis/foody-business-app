import 'package:json_annotation/json_annotation.dart';

import '../../utils/date_json_serializer.dart';

part '../mapper/request/booking_request_dto.g.dart';

@JsonSerializable()
class BookingRequestDto {
  const BookingRequestDto({
    required this.date,
    required this.seats,
    required this.sittingTimeId,
    required this.restaurantId,
  });

  factory BookingRequestDto.fromJson(Map<String, dynamic> json) =>
      _$BookingRequestDtoFromJson(json);

  @JsonKey(fromJson: dateFromJson, toJson: dateToJson)
  final DateTime date;

  final int seats;
  final int sittingTimeId;
  final int restaurantId;

  Map<String, dynamic> toJson() => _$BookingRequestDtoToJson(this);
}
