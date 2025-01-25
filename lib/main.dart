import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_api_client/foody_api_client.dart';
import 'package:foody_api_client/utils/get_foody_dio.dart';
import 'package:foody_business_app/repository/impl/user_repository_impl.dart';
import 'package:foody_business_app/repository/interface/user_repository.dart';
import 'package:foody_business_app/utils/get_token_interceptor.dart';

import 'bloc/foody/foody_bloc.dart';
import 'foody.dart';
import 'object_box/objectbox.dart';

late ObjectBox objectBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  objectBox = await ObjectBox.create();

  final userRepository = UserRepositoryImpl();
  final token = userRepository.get()?.jwt;
  final tokenInterceptor = token != null
      ? getTokenInterceptor(token: token, userRepository: userRepository)
      : null;

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (_) => userRepository,
        ),
        RepositoryProvider<FoodyApiClient>(
          create: (_) => FoodyApiClient(
            dio: getFoodyDio(tokenInterceptor: tokenInterceptor),
          ),
        ),
      ],
      child: BlocProvider<FoodyBloc>(
        create: (context) => FoodyBloc(userRepository: userRepository),
        child: const Foody(),
      ),
    ),
  );
}
