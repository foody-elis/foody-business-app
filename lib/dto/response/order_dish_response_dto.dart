import 'package:json_annotation/json_annotation.dart';

part '../mapper/response/order_dish_response_dto.g.dart';

@JsonSerializable()
class OrderDishResponseDto {
  const OrderDishResponseDto({
    required this.dishId,
    required this.dishName,
    required this.price,
    required this.quantity,
  });

  factory OrderDishResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDishResponseDtoFromJson(json);

  final int dishId;
  final String dishName;
  final double price;
  final int quantity;

  Map<String, dynamic> toJson() => _$OrderDishResponseDtoToJson(this);
}
