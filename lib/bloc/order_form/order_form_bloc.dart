import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_api_client/dto/request/order_request_dto.dart';
import 'package:foody_api_client/dto/response/dish_response_dto.dart';
import 'package:foody_api_client/dto/response/order_response_dto.dart';
import 'package:foody_api_client/foody_api_client.dart';
import 'package:foody_api_client/utils/call_api.dart';
import 'package:foody_business_app/bloc/order_form/order_form_event.dart';
import 'package:foody_business_app/bloc/order_form/order_form_state.dart';
import 'package:foody_business_app/repository/interface/user_repository.dart';
import 'package:foody_business_app/routing/constants.dart';
import 'package:foody_business_app/routing/navigation_service.dart';

class OrderFormBloc extends Bloc<OrderFormEvent, OrderFormState> {
  final FoodyApiClient foodyApiClient;
  final UserRepository userRepository;
  final NavigationService _navigationService = NavigationService();

  late final int _restaurantId;

  OrderFormBloc({
    required this.foodyApiClient,
    required this.userRepository,
  }) : super(OrderFormState.initial()) {
    on<SummarySubmit>(_onSummarySubmit, transformer: droppable());
    on<FetchDishes>(_onFetchDishes, transformer: droppable());
    on<TableCodeSubmit>(_onTableCodeSubmit);
    on<OrderDishesSubmit>(_onOrderDishesSubmit);
    on<OrderCartSubmit>(_onOrderCartSubmit);
    on<TableCodeChanged>(_onTableCodeChanged);
    on<AddOrderDish>(_onAddOrderDish);
    on<RemoveOrderDish>(_onRemoveOrderDish);
    on<StepChanged>(_onStepChanged);
    on<PreviousStep>(_onPreviousStep);
    on<Logout>(_onLogout);

    _restaurantId = userRepository.get()!.restaurantId!;
  }

  void _onLogout(Logout event, Emitter<OrderFormState> emit) {
    userRepository.removeAll();
    NavigationService().resetToScreen(signInRoute);
  }

  void _onFetchDishes(FetchDishes event, Emitter<OrderFormState> emit) async {
    emit(state.copyWith(isLoading: true));

    await callApi<List<DishResponseDto>>(
      api: () => foodyApiClient.dishes.getAllByRestaurant(_restaurantId),
      onComplete: (dishes) => emit(state.copyWith(
        dishes: dishes,
        isLoading: false,
      )),
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );
  }

  void _onSummarySubmit(
      SummarySubmit event, Emitter<OrderFormState> emit) async {
    emit(state.copyWith(isLoading: true));

    await callApi<OrderResponseDto>(
      api: () => foodyApiClient.orders.save(
        OrderRequestDto(
          tableCode: state.tableCode,
          orderDishes: state.orderDishes.toList(),
          restaurantId: _restaurantId,
        ),
      ),
      onComplete: (order) => _navigationService.replaceScreen(
        orderCompletedRoute,
        arguments: {"order": order},
      ),
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );

    emit(state.copyWith(isLoading: false));
  }

  void _onTableCodeChanged(
      TableCodeChanged event, Emitter<OrderFormState> emit) async {
    emit(state.copyWith(tableCode: event.tableCode, tableCodeError: "null"));
  }

  void _onAddOrderDish(AddOrderDish event, Emitter<OrderFormState> emit) {
    final orderDishes = List.of(state.orderDishes);

    final orderDishIndex = orderDishes
        .indexWhere((orderDish) => orderDish.dishId == event.orderDish.dishId);

    if (orderDishIndex == -1) {
      orderDishes.add(event.orderDish);
    } else {
      final qtyAlreadyInserted = orderDishes[orderDishIndex].quantity;

      orderDishes[orderDishIndex] = event.orderDish.copyWith(
        quantity: qtyAlreadyInserted + event.orderDish.quantity,
      );
    }

    emit(state.copyWith(orderDishes: orderDishes));
  }

  void _onRemoveOrderDish(RemoveOrderDish event, Emitter<OrderFormState> emit) {
    final orderDishes = List.of(state.orderDishes);

    if (event.removeAllQty) {
      orderDishes.removeWhere((orderDish) => orderDish.dishId == event.dishId);
    } else {
      final orderDishIndex = orderDishes
          .indexWhere((orderDish) => orderDish.dishId == event.dishId);

      final newQty = orderDishes[orderDishIndex].quantity - 1;

      if (newQty <= 0) {
        orderDishes.removeAt(orderDishIndex);
      } else {
        orderDishes[orderDishIndex] = orderDishes[orderDishIndex].copyWith(
          quantity: orderDishes[orderDishIndex].quantity - 1,
        );
      }
    }

    emit(state.copyWith(orderDishes: orderDishes));
  }

  void _onStepChanged(StepChanged event, Emitter<OrderFormState> emit) {
    emit(state.copyWith(activeStep: event.step));
  }

  void _onPreviousStep(PreviousStep event, Emitter<OrderFormState> emit) {
    if (state.activeStep == 0) {
      _navigationService.goBack();
    } else {
      emit(state.copyWith(activeStep: state.activeStep - 1));
    }
  }

  void _onTableCodeSubmit(
      TableCodeSubmit event, Emitter<OrderFormState> emit) async {
    if (state.tableCode.trim().isEmpty) {
      emit(state.copyWith(
          tableCodeError: "Il numero del tavolo è obbligatorio"));
    } else {
      emit(state.copyWith(activeStep: 1));
      add(FetchDishes());
    }
  }

  void _onOrderDishesSubmit(
      OrderDishesSubmit event, Emitter<OrderFormState> emit) async {
    emit(state.copyWith(activeStep: 2));
  }

  void _onOrderCartSubmit(
      OrderCartSubmit event, Emitter<OrderFormState> emit) async {
    if (state.orderDishes.isEmpty) {
      emit(state.copyWith(
          apiError: "Devi avere almeno un piatto nel carrello per procedere"));
      emit(state.copyWith(apiError: ""));
    } else {
      emit(state.copyWith(activeStep: 3));
    }
  }
}
