import 'package:json_annotation/json_annotation.dart';

part '../mapper/request/order_dish_request_dto.g.dart';

@JsonSerializable()
class OrderDishRequestDto {
  const OrderDishRequestDto({
    required this.dishId,
    required this.quantity,
  });

  factory OrderDishRequestDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDishRequestDtoFromJson(json);

  final int dishId;
  final int quantity;

  Map<String, dynamic> toJson() => _$OrderDishRequestDtoToJson(this);

  OrderDishRequestDto copyWith({
    int? dishId,
    int? quantity,
  }) {
    return OrderDishRequestDto(
      dishId: dishId ?? this.dishId,
      quantity: quantity ?? this.quantity,
    );
  }
}
