import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_business_app/dto/request/user_login_request_dto.dart';
import 'package:foody_business_app/dto/response/auth_response_dto.dart';
import 'package:foody_business_app/repository/interface/user_repository.dart';
import 'package:foody_business_app/routing/constants.dart';
import 'package:foody_business_app/utils/get_foody_dio.dart';
import 'package:foody_business_app/utils/roles.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../models/user.dart';
import '../../repository/interface/foody_api_repository.dart';
import '../../routing/navigation_service.dart';
import '../../utils/call_api.dart';
import '../../utils/token_inteceptor.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final NavigationService _navigationService = NavigationService();
  final FoodyApiRepository foodyApiRepository;
  final UserRepository userRepository;

  SignInBloc({required this.foodyApiRepository, required this.userRepository})
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

  void _onLoginSubmit(LoginSubmit event, Emitter<SignInState> emit) async {
    if (_isFormValid(emit)) {
      foodyApiRepository.dio = getFoodyDio(); // reset dio in case of 498

      emit(state.copyWith(isLoading: true));

      await callApi<AuthResponseDto>(
        api: () => foodyApiRepository.auth.login(UserLoginRequestDto(
          email: state.email,
          password: state.password,
        )),
        onComplete: (response) {
          final user = User(
            jwt: response.accessToken,
            role: JwtDecoder.decode(response.accessToken)["role"],
          );

          if (user.role != Role.WAITER && user.role != Role.COOK) {
            emit(state.copyWith(apiError: "Credenziali errate"));
            emit(state.copyWith(apiError: ""));
            return;
          }

          userRepository.add(user);
          foodyApiRepository.dio = getFoodyDio(
              tokenInterceptor: TokenInterceptor(
            token: response.accessToken,
            userRepository: userRepository,
          ));
          _navigationService.resetToScreen(
              user.role == Role.WAITER ? ordersRoute : orderFormRoute);
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
