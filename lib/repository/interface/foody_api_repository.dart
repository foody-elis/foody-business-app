import 'package:dio/dio.dart';
import 'package:foody_business_app/repository/interface/auth_api_repository.dart';
import 'package:foody_business_app/repository/interface/bookings_api_repository.dart';
import 'package:foody_business_app/repository/interface/categories_api_repository.dart';
import 'package:foody_business_app/repository/interface/dishes_api_repository.dart';
import 'package:foody_business_app/repository/interface/restaurants_api_repository.dart';
import 'package:foody_business_app/repository/interface/reviews_api_repository.dart';
import 'package:foody_business_app/repository/interface/sitting_times_api_repository.dart';
import 'package:foody_business_app/repository/interface/users_api_repository.dart';
import 'package:foody_business_app/repository/interface/weekdays_info_api_repository.dart';

import 'orders_api_repository.dart';

class FoodyApiRepository {
  late AuthApiRepository auth;
  late CategoriesApiRepository categories;
  late RestaurantsApiRepository restaurants;
  late WeekdaysInfoApiRepository weekdayInfo;
  late SittingTimesApiRepository sittingTimes;
  late BookingsApiRepository bookings;
  late DishesApiRepository dishes;
  late ReviewsApiRepository reviews;
  late OrdersApiRepository orders;
  late UsersApiRepository users;

  FoodyApiRepository({required Dio dio}) {
    this.dio = dio;
  }

  set dio(Dio dio) {
    auth = AuthApiRepository(dio, baseUrl: "${dio.options.baseUrl}/auth");
    categories = CategoriesApiRepository(dio,
        baseUrl: "${dio.options.baseUrl}/categories");
    restaurants = RestaurantsApiRepository(dio,
        baseUrl: "${dio.options.baseUrl}/restaurants");
    weekdayInfo = WeekdaysInfoApiRepository(dio,
        baseUrl: "${dio.options.baseUrl}/week-day-infos");
    sittingTimes = SittingTimesApiRepository(dio,
        baseUrl: "${dio.options.baseUrl}/sitting-times");
    bookings =
        BookingsApiRepository(dio, baseUrl: "${dio.options.baseUrl}/bookings");
    dishes = DishesApiRepository(dio, baseUrl: "${dio.options.baseUrl}/dishes");
    reviews =
        ReviewsApiRepository(dio, baseUrl: "${dio.options.baseUrl}/reviews");
    orders = OrdersApiRepository(dio, baseUrl: "${dio.options.baseUrl}/orders");
    users = UsersApiRepository(dio, baseUrl: "${dio.options.baseUrl}/users");
  }
}
