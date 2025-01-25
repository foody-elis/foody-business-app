import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_api_client/foody_api_client.dart';
import 'package:foody_business_app/bloc/orders/orders_bloc.dart';
import 'package:foody_business_app/bloc/sign_in/sign_in_bloc.dart';
import 'package:foody_business_app/repository/interface/user_repository.dart';
import 'package:foody_business_app/routing/constants.dart';
import 'package:foody_business_app/screens/order_completed.dart';
import 'package:foody_business_app/screens/orders/orders.dart';
import 'package:foody_business_app/screens/sign_in.dart';

import '../bloc/order_form/order_form_bloc.dart';
import '../screens/order_form/order_form.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case signInRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider<SignInBloc>(
            create: (context) => SignInBloc(
              foodyApiClient: context.read<FoodyApiClient>(),
              userRepository: context.read<UserRepository>(),
            ),
            child: const SignIn(),
          ),
        );
      case orderFormRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider<OrderFormBloc>(
            create: (context) => OrderFormBloc(
              foodyApiClient: context.read<FoodyApiClient>(),
              userRepository: context.read<UserRepository>(),
            ),
            child: const OrderForm(),
          ),
        );
      case orderCompletedRoute:
        return CupertinoPageRoute(
          builder: (_) => OrderCompleted(order: arguments!["order"]),
        );
      case ordersRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider<OrdersBloc>(
            create: (context) => OrdersBloc(
              foodyApiClient: context.read<FoodyApiClient>(),
              userRepository: context.read<UserRepository>(),
            ),
            child: const Orders(),
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
