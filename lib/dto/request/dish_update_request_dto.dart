import 'package:json_annotation/json_annotation.dart';

part '../mapper/request/dish_update_request_dto.g.dart';

@JsonSerializable()
class DishUpdateRequestDto {
  const DishUpdateRequestDto({
    required this.name,
    required this.description,
    required this.price,
    required this.photoBase64,
  });

  factory DishUpdateRequestDto.fromJson(Map<String, dynamic> json) =>
      _$DishUpdateRequestDtoFromJson(json);

  final String name;
  final String description;
  final double price;
  final String? photoBase64;

  Map<String, dynamic> toJson() => _$DishUpdateRequestDtoToJson(this);
}
