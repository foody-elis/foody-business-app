import 'dart:io';

import 'package:dio/dio.dart';
import 'package:foody_business_app/repository/interface/user_repository.dart';
import 'package:foody_business_app/routing/constants.dart';
import 'package:foody_business_app/routing/navigation_service.dart';

class TokenInterceptor extends Interceptor {
  TokenInterceptor({required this.token, required this.userRepository});

  final String token;
  final NavigationService _navigationService = NavigationService();
  final UserRepository userRepository;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 498) {
      userRepository.removeAll();
      _navigationService.resetToScreen(signInRoute);
    }

    super.onError(err, handler);
  }
}
