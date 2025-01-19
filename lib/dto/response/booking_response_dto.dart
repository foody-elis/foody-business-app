import 'package:foody_business_app/dto/response/restaurant_response_dto.dart';
import 'package:foody_business_app/dto/response/sitting_time_response_dto.dart';
import 'package:foody_business_app/dto/response/user_response_dto.dart';
import 'package:foody_business_app/utils/booking_status.dart';
import 'package:json_annotation/json_annotation.dart';

part '../mapper/response/booking_response_dto.g.dart';

@JsonSerializable()
class BookingResponseDto {
  const BookingResponseDto({
    required this.id,
    required this.date,
    required this.seats,
    required this.sittingTime,
    required this.customer,
    required this.restaurant,
    required this.status,
  });

  factory BookingResponseDto.fromJson(Map<String, dynamic> json) =>
      _$BookingResponseDtoFromJson(json);

  final int id;
  final DateTime date;
  final int seats;
  final SittingTimeResponseDto sittingTime;
  final UserResponseDto customer;
  final RestaurantResponseDto restaurant;
  final BookingStatus status;

  Map<String, dynamic> toJson() => _$BookingResponseDtoToJson(this);
}
