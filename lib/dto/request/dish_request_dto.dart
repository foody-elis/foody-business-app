import 'package:foody_business_app/dto/request/dish_update_request_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part '../mapper/request/dish_request_dto.g.dart';

@JsonSerializable()
class DishRequestDto extends DishUpdateRequestDto {
  const DishRequestDto({
    required super.name,
    required super.description,
    required super.price,
    required super.photoBase64,
    required this.restaurantId,
  });

  factory DishRequestDto.fromJson(Map<String, dynamic> json) =>
      _$DishRequestDtoFromJson(json);

  final int restaurantId;

  Map<String, dynamic> toJson() => _$DishRequestDtoToJson(this);
}
