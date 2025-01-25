import 'package:equatable/equatable.dart';
import 'package:foody_business_app/dto/response/order_response_dto.dart';

class OrdersState extends Equatable {
  final List<OrderResponseDto> orders;
  final Map<OrderResponseDto, int> dismissedOrders;
  final String apiError;
  final bool isLoading;

  const OrdersState({
    required this.orders,
    required this.dismissedOrders,
    required this.apiError,
    required this.isLoading,
  });

  OrdersState.initial()
      : orders = [],
        dismissedOrders = {},
        apiError = "",
        isLoading = false;

  OrdersState copyWith({
    List<OrderResponseDto>? orders,
    Map<OrderResponseDto, int>? dismissedOrders,
    String? apiError,
    bool? isLoading,
  }) {
    return OrdersState(
      orders: orders ?? this.orders,
      dismissedOrders: dismissedOrders ?? this.dismissedOrders,
      apiError: apiError ?? this.apiError,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        orders,
        dismissedOrders,
        apiError,
        isLoading,
      ];
}
