import 'package:json_annotation/json_annotation.dart';

part '../mapper/response/order_dish_response_dto.g.dart';

@JsonSerializable()
class OrderDishResponseDto {
  const OrderDishResponseDto({
    required this.dishId,
    required this.quantity,
  });

  factory OrderDishResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDishResponseDtoFromJson(json);

  final int dishId;
  final int quantity;

  Map<String, dynamic> toJson() => _$OrderDishResponseDtoToJson(this);
}
