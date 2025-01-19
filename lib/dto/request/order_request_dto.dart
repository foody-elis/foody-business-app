import 'package:foody_business_app/dto/request/order_dish_request_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part '../mapper/request/order_request_dto.g.dart';

@JsonSerializable()
class OrderRequestDto {
  const OrderRequestDto({
    required this.tableCode,
    required this.orderDishes,
    required this.restaurantId,
  });

  factory OrderRequestDto.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestDtoFromJson(json);

  final String tableCode;
  final List<OrderDishRequestDto> orderDishes;
  final int restaurantId;

  Map<String, dynamic> toJson() => _$OrderRequestDtoToJson(this);
}
