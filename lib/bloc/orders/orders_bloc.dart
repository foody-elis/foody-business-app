import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_api_client/dto/response/order_response_dto.dart';
import 'package:foody_api_client/foody_api_client.dart';
import 'package:foody_api_client/utils/call_api.dart';
import 'package:foody_api_client/utils/order_status.dart';
import 'package:foody_business_app/bloc/orders/orders_event.dart';
import 'package:foody_business_app/bloc/orders/orders_state.dart';
import 'package:foody_business_app/repository/interface/user_repository.dart';
import 'package:foody_business_app/routing/constants.dart';
import 'package:foody_business_app/routing/navigation_service.dart';
import 'package:foody_business_app/utils/foody_stomp_client.dart';
import 'package:foody_business_app/utils/websocket_topics.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final FoodyApiClient foodyApiClient;
  final UserRepository userRepository;
  final NavigationService _navigationService = NavigationService();

  late final int _restaurantId;
  late final FoodyStompClient _stompClient;

  OrdersBloc({
    required this.foodyApiClient,
    required this.userRepository,
  }) : super(OrdersState.initial()) {
    on<FetchOrders>(_onFetchOrders, transformer: droppable());
    on<MarkOrderAsPreparing>(_onMarkOrderAsPreparing);
    on<MarkOrderAsCompleted>(_onMarkOrderAsCompleted);
    on<StompInit>(_onStompInit, transformer: droppable());
    on<WsOrderPayed>(_onWsOrderPayed);
    on<WsOrderPreparing>(_onWsOrderPreparing);
    on<WsOrderCompleted>(_onWsOrderCompleted);
    on<Logout>(_onLogout);
    on<Dismiss>(_onDismiss);
    on<UndoDismiss>(_onUndoDismiss);

    _restaurantId = userRepository.get()!.restaurantId!;

    add(FetchOrders());
    add(StompInit());
  }

  void _onStompInit(StompInit event, Emitter<OrdersState> emit) {
    _stompClient = FoodyStompClient(
      jwt: userRepository.get()!.jwt,
      onConnect: (_) {
        _stompClient.subscribe<OrderResponseDto>(
          destination:
              '${WebSocketTopics.TOPIC_ORDERS_PAYED.name}$_restaurantId',
          dtoFromJson: (v) => OrderResponseDto.fromJson(v),
          callback: (order) => add(WsOrderPayed(order: order)),
        );

        _stompClient.subscribe<OrderResponseDto>(
          destination:
              '${WebSocketTopics.TOPIC_ORDERS_PREPARING.name}$_restaurantId',
          dtoFromJson: (v) => OrderResponseDto.fromJson(v),
          callback: (order) => add(WsOrderPreparing(orderId: order.id)),
        );

        _stompClient.subscribe<OrderResponseDto>(
          destination:
              '${WebSocketTopics.TOPIC_ORDERS_COMPLETED.name}$_restaurantId',
          dtoFromJson: (v) => OrderResponseDto.fromJson(v),
          callback: (order) => add(WsOrderCompleted(orderId: order.id)),
        );
      },
    );
  }

  void _onWsOrderPayed(WsOrderPayed event, Emitter<OrdersState> emit) {
    emit(state.copyWith(orders: List.of(state.orders)..insert(0, event.order)));
  }

  void _onWsOrderPreparing(WsOrderPreparing event, Emitter<OrdersState> emit) {
    emit(state.copyWith(
      orders: List.of(state.orders)
          .map(
            (o) => o.id == event.orderId
                ? o.copyWith(status: OrderStatus.PREPARING)
                : o,
          )
          .toList(),
    ));
  }

  void _onWsOrderCompleted(WsOrderCompleted event, Emitter<OrdersState> emit) {
    emit(
      state.copyWith(
          orders: List.of(state.orders)
            ..removeWhere((o) => o.id == event.orderId),
          dismissedOrders: Map.of(state.dismissedOrders)
            ..removeWhere((o, i) => o.id == event.orderId)),
    );
  }

  void _onLogout(Logout event, Emitter<OrdersState> emit) {
    userRepository.removeAll();
    NavigationService().resetToScreen(signInRoute);
  }

  void _onFetchOrders(FetchOrders event, Emitter<OrdersState> emit) async {
    emit(state.copyWith(isLoading: true));

    await callApi<List<OrderResponseDto>>(
      api: () => foodyApiClient.orders.getCurrentByRestaurant(_restaurantId),
      onComplete: (orders) => emit(state.copyWith(orders: orders)),
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );

    emit(state.copyWith(isLoading: false));
  }

  void _onMarkOrderAsPreparing(
      MarkOrderAsPreparing event, Emitter<OrdersState> emit) async {
    _navigationService.goBack();
    emit(state.copyWith(isLoading: true));

    await callApi<OrderResponseDto>(
      api: () => foodyApiClient.orders.prepare(event.orderId),
      onComplete: (_) => add(WsOrderPreparing(orderId: event.orderId)),
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );

    emit(state.copyWith(isLoading: false));
  }

  void _onMarkOrderAsCompleted(
      MarkOrderAsCompleted event, Emitter<OrdersState> emit) async {
    if (!event.fromDismiss) _navigationService.goBack();
    emit(state.copyWith(isLoading: true));

    await callApi<OrderResponseDto>(
      api: () => foodyApiClient.orders.complete(event.orderId),
      onComplete: (_) {
        add(WsOrderCompleted(orderId: event.orderId));
      },
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );

    emit(state.copyWith(isLoading: false));
  }

  void _onDismiss(Dismiss event, Emitter<OrdersState> emit) {
    emit(state.copyWith(
      orders: List.of(state.orders)..remove(event.order),
      dismissedOrders: Map.of(state.dismissedOrders)
        ..[event.order] = event.index,
    ));
  }

  void _onUndoDismiss(UndoDismiss event, Emitter<OrdersState> emit) {
    final index = state.dismissedOrders[event.order];

    if (index != null) {
      emit(state.copyWith(
        orders: List.of(state.orders)..insert(index, event.order),
        dismissedOrders: Map.of(state.dismissedOrders)..remove(event.order),
      ));
    }
  }
}
