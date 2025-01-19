import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/interface/user_repository.dart';
import 'foody_event.dart';
import 'foody_state.dart';

class FoodyBloc extends Bloc<FoodyEvent, FoodyState> {
  final UserRepository userRepository;

  FoodyBloc({
    required this.userRepository,
  }) : super(FoodyState.initial(
            userRepository.isLogged(), userRepository.isWaiter())) {
    on<ShowLoadingOverlayChanged>(_onShowLoadingOverlayChanged);
  }

  void _onShowLoadingOverlayChanged(
      ShowLoadingOverlayChanged event, Emitter<FoodyState> emit) {
    emit(state.copyWith(showLoadingOverlay: event.show));
  }
}
