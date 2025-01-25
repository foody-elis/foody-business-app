import 'package:equatable/equatable.dart';
import 'package:foody_business_app/dto/response/order_response_dto.dart';

class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class Logout extends OrdersEvent {}

class FetchOrders extends OrdersEvent {}

class StompInit extends OrdersEvent {}

class WsOrderPayed extends OrdersEvent {
  const WsOrderPayed({required this.order});

  final OrderResponseDto order;

  @override
  List<Object> get props => [order];
}

class WsOrderPreparing extends OrdersEvent {
  const WsOrderPreparing({required this.orderId});

  final int orderId;

  @override
  List<Object> get props => [orderId];
}

class WsOrderCompleted extends OrdersEvent {
  const WsOrderCompleted({required this.orderId});

  final int orderId;

  @override
  List<Object> get props => [orderId];
}

class MarkOrderAsCompleted extends OrdersEvent {
  const MarkOrderAsCompleted({required this.orderId, this.fromDismiss = false});

  final int orderId;
  final bool fromDismiss;

  @override
  List<Object> get props => [orderId];
}

class MarkOrderAsPreparing extends OrdersEvent {
  const MarkOrderAsPreparing({required this.orderId});

  final int orderId;

  @override
  List<Object> get props => [orderId];
}

class Dismiss extends OrdersEvent {
  const Dismiss({required this.order, required this.index});

  final OrderResponseDto order;
  final int index;

  @override
  List<Object> get props => [order];
}

class UndoDismiss extends OrdersEvent {
  const UndoDismiss({required this.order});

  final OrderResponseDto order;

  @override
  List<Object> get props => [order];
}
