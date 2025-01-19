import 'package:equatable/equatable.dart';

class FoodyEvent extends Equatable {
  const FoodyEvent();

  @override
  List<Object> get props => [];
}

class ShowLoadingOverlayChanged extends FoodyEvent {
  const ShowLoadingOverlayChanged({required this.show});

  final bool show;

  @override
  List<Object> get props => [show];
}
