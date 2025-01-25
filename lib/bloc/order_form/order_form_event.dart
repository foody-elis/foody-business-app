import 'package:equatable/equatable.dart';
import 'package:foody_api_client/dto/request/order_dish_request_dto.dart';

class OrderFormEvent extends Equatable {
  const OrderFormEvent();

  @override
  List<Object> get props => [];
}

class Logout extends OrderFormEvent {}

class TableCodeSubmit extends OrderFormEvent {}

class OrderDishesSubmit extends OrderFormEvent {}

class OrderCartSubmit extends OrderFormEvent {}

class SummarySubmit extends OrderFormEvent {}

class FetchDishes extends OrderFormEvent {}

class PreviousStep extends OrderFormEvent {}

class TableCodeChanged extends OrderFormEvent {
  const TableCodeChanged({required this.tableCode});

  final String tableCode;

  @override
  List<Object> get props => [tableCode];
}

class AddOrderDish extends OrderFormEvent {
  const AddOrderDish({required this.orderDish});

  final OrderDishRequestDto orderDish;

  @override
  List<Object> get props => [orderDish];
}

class RemoveOrderDish extends OrderFormEvent {
  const RemoveOrderDish({required this.dishId, this.removeAllQty = false});

  final int dishId;
  final bool removeAllQty;

  @override
  List<Object> get props => [dishId];
}

class StepChanged extends OrderFormEvent {
  const StepChanged({required this.step});

  final int step;

  @override
  List<Object> get props => [step];
}
