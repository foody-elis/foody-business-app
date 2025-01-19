import 'package:equatable/equatable.dart';

class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmit extends SignInEvent {}

class EmailChanged extends SignInEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends SignInEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}
