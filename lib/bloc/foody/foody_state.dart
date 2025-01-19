import 'package:equatable/equatable.dart';

import '../../routing/constants.dart';

class FoodyState extends Equatable {
  final String initialRoute;
  final bool showLoadingOverlay;

  const FoodyState({
    required this.initialRoute,
    required this.showLoadingOverlay,
  });

  const FoodyState.initial(bool isLogged, bool isWaiter)
      : initialRoute = isLogged
            ? isWaiter
                ? orderFormRoute
                : ordersRoute
            : signInRoute,
        showLoadingOverlay = false;

  FoodyState copyWith({
    bool? darkTheme,
    bool? copyWithTap,
    bool? showLoadingOverlay,
  }) {
    return FoodyState(
      initialRoute: initialRoute,
      showLoadingOverlay: showLoadingOverlay ?? this.showLoadingOverlay,
    );
  }

  @override
  List<Object> get props => [showLoadingOverlay];
}
