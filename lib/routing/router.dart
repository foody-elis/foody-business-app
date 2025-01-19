import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_business_app/bloc/sign_in/sign_in_bloc.dart';
import 'package:foody_business_app/repository/interface/foody_api_repository.dart';
import 'package:foody_business_app/repository/interface/user_repository.dart';
import 'package:foody_business_app/routing/constants.dart';
import 'package:foody_business_app/screens/sign_in.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case signInRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider<SignInBloc>(
            create: (context) => SignInBloc(
              foodyApiRepository: context.read<FoodyApiRepository>(),
              userRepository: context.read<UserRepository>(),
            ),
            child: const SignIn(),
          ),
        );
      default:
        return CupertinoPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
