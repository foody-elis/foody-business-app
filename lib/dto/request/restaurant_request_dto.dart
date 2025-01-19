import 'package:json_annotation/json_annotation.dart';

part '../mapper/request/restaurant_request_dto.g.dart';

@JsonSerializable()
class RestaurantRequestDto {
  const RestaurantRequestDto({
    required this.name,
    required this.description,
    required this.phoneNumber,
    required this.street,
    required this.civicNumber,
    required this.city,
    required this.province,
    required this.postalCode,
    required this.seats,
    required this.categories,
    required this.photoBase64,
  });

  factory RestaurantRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RestaurantRequestDtoFromJson(json);

  final String name;
  final String description;
  final String phoneNumber;
  final String street;
  final String civicNumber;
  final String city;
  final String province;
  final String postalCode;
  final int seats;
  final List<int> categories;
  final String? photoBase64;

  Map<String, dynamic> toJson() => _$RestaurantRequestDtoToJson(this);
}
