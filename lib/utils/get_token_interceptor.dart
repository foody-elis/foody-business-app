import 'package:foody_api_client/utils/token_inteceptor.dart';

import '../repository/interface/user_repository.dart';
import '../routing/constants.dart';
import '../routing/navigation_service.dart';

TokenInterceptor getTokenInterceptor({
  required String token,
  required UserRepository userRepository,
}) =>
    TokenInterceptor(
      token: token,
      onInvalidToken: () {
        TokenInterceptor(
            token: token,
            onInvalidToken: () {
              userRepository.removeAll();
              NavigationService().resetToScreen(signInRoute);
            });
      },
    );
