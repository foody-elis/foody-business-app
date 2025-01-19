import 'package:foody_business_app/dto/response/dish_response_dto.dart';
import 'package:foody_business_app/dto/response/restaurant_response_dto.dart';
import 'package:foody_business_app/dto/response/review_response_dto.dart';
import 'package:foody_business_app/dto/response/sitting_time_response_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'category_response_dto.dart';

part '../mapper/response/detailed_restaurant_response_dto.g.dart';

@JsonSerializable()
class DetailedRestaurantResponseDto extends RestaurantResponseDto {
  const DetailedRestaurantResponseDto({
    required this.averageRating,
    required this.dishes,
    required this.sittingTimes,
    required this.reviews,
    required super.id,
    required super.name,
    required super.description,
    required super.phoneNumber,
    required super.street,
    required super.civicNumber,
    required super.city,
    required super.province,
    required super.postalCode,
    required super.seats,
    required super.approved,
    required super.restaurateurId,
    required super.restaurateurEmail,
    required super.categories,
    required super.photoUrl,
  });

  factory DetailedRestaurantResponseDto.fromJson(Map<String, dynamic> json) =>
      _$DetailedRestaurantResponseDtoFromJson(json);

  final double averageRating;
  final List<SittingTimeResponseDto> sittingTimes;
  final List<DishResponseDto> dishes;
  final List<ReviewResponseDto> reviews;

  Map<String, dynamic> toJson() => _$DetailedRestaurantResponseDtoToJson(this);
}
