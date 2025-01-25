import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_api_client/dto/request/user_login_request_dto.dart';
import 'package:foody_api_client/dto/response/auth_response_dto.dart';
import 'package:foody_api_client/dto/response/employee_user_response_dto.dart';
import 'package:foody_api_client/foody_api_client.dart';
import 'package:foody_api_client/utils/call_api.dart';
import 'package:foody_api_client/utils/get_foody_dio.dart';
import 'package:foody_api_client/utils/roles.dart';
import 'package:foody_business_app/repository/interface/user_repository.dart';
import 'package:foody_business_app/routing/constants.dart';
import 'package:foody_business_app/utils/get_token_interceptor.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../models/user.dart';
import '../../routing/navigation_service.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final NavigationService _navigationService = NavigationService();
  final FoodyApiClient foodyApiClient;
  final UserRepository userRepository;

  SignInBloc({required this.foodyApiClient, required this.userRepository})
      : super(const SignInState.initial()) {
    on<LoginSubmit>(_onLoginSubmit, transformer: droppable());
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
  }

  bool _isFormValid(Emitter<SignInState> emit) {
    bool isValid = true;

    if (state.email.isEmpty) {
      emit(state.copyWith(emailError: "L'email è obbligatoria"));
      isValid = false;
    } else if (!EmailValidator.validate(state.email)) {
      emit(state.copyWith(emailError: "L'email non è valida"));
      isValid = false;
    }

    if (state.password.isEmpty) {
      emit(state.copyWith(passwordError: "La password è obbligatoria"));
      isValid = false;
    }

    return isValid;
  }

  Future<int?> _getRestaurantId() async {
    int? result;

    await callApi<EmployeeUserResponseDto>(
      api: foodyApiClient.auth.getAuthenticatedUser,
      onComplete: (response) => result = response.employerRestaurantId,
    );

    return result;
  }

  void _onLoginSubmit(LoginSubmit event, Emitter<SignInState> emit) async {
    if (_isFormValid(emit)) {
      foodyApiClient.dio = getFoodyDio(); // reset dio in case of 498

      emit(state.copyWith(isLoading: true));

      await callApi<AuthResponseDto>(
        api: () => foodyApiClient.auth.login(UserLoginRequestDto(
          email: state.email,
          password: state.password,
        )),
        onComplete: (response) async {
          final user = User(
            jwt: response.accessToken,
            role: JwtDecoder.decode(response.accessToken)["role"],
          );

          if (user.role != Role.WAITER && user.role != Role.COOK) {
            emit(state.copyWith(apiError: "Credenziali errate"));
            emit(state.copyWith(apiError: ""));
            return;
          }

          foodyApiClient.dio = getFoodyDio(
              tokenInterceptor: getTokenInterceptor(
            token: response.accessToken,
            userRepository: userRepository,
          ));

          final restaurantId = await _getRestaurantId();

          if (restaurantId == null) {
            emit(state.copyWith(apiError: "Credenziali errate"));
            emit(state.copyWith(apiError: ""));
            return;
          }

          user.restaurantId = restaurantId;

          userRepository.add(user);

          _navigationService.resetToScreen(
              user.role == Role.WAITER ? orderFormRoute : ordersRoute);
        },
        errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
      );

      emit(state.copyWith(isLoading: false));
    }
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignInState> emit) {
    emit(state.copyWith(email: event.email, emailError: "null"));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignInState> emit) {
    emit(state.copyWith(password: event.password, passwordError: "null"));
  }
}
