import 'package:equatable/equatable.dart';
import 'package:foody_business_app/dto/request/order_dish_request_dto.dart';
import 'package:foody_business_app/dto/response/dish_response_dto.dart';

class OrderFormState extends Equatable {
  final String tableCode;
  final List<OrderDishRequestDto> orderDishes;
  final List<DishResponseDto> dishes;
  final int activeStep;
  final String? tableCodeError;
  final String apiError;
  final bool isLoading;

  const OrderFormState({
    required this.tableCode,
    required this.orderDishes,
    required this.dishes,
    required this.activeStep,
    required this.apiError,
    required this.tableCodeError,
    required this.isLoading,
  });

  OrderFormState.initial()
      : tableCode = "",
        orderDishes = [],
        dishes = [],
        activeStep = 0,
        tableCodeError = null,
        apiError = "",
        isLoading = false;

  OrderFormState copyWith({
    String? tableCode,
    List<OrderDishRequestDto>? orderDishes,
    List<DishResponseDto>? dishes,
    int? activeStep,
    String? tableCodeError,
    String? apiError,
    bool? isLoading,
  }) {
    return OrderFormState(
      tableCode: tableCode ?? this.tableCode,
      orderDishes: orderDishes ?? this.orderDishes,
      dishes: dishes ?? this.dishes,
      activeStep: activeStep ?? this.activeStep,
      tableCodeError: tableCodeError == "null"
          ? null
          : tableCodeError ?? this.tableCodeError,
      apiError: apiError ?? this.apiError,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        tableCode,
        orderDishes,
        dishes,
        activeStep,
        tableCodeError,
        apiError,
        isLoading,
      ];
}
