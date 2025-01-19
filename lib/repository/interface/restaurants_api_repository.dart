import 'package:dio/dio.dart';
import 'package:foody_business_app/dto/request/restaurant_request_dto.dart';
import 'package:foody_business_app/dto/response/detailed_restaurant_response_dto.dart';
import 'package:foody_business_app/dto/response/restaurant_response_dto.dart';
import 'package:retrofit/http.dart';

part '../generated/interface/restaurants_api_repository.g.dart';

@RestApi()
abstract class RestaurantsApiRepository {
  factory RestaurantsApiRepository(Dio dio, {String? baseUrl}) =
      _RestaurantsApiRepository;

  @POST('')
  Future<RestaurantResponseDto> save(@Body() RestaurantRequestDto _);

  @PUT('/{id}')
  Future<RestaurantResponseDto> edit(
      @Path() int id, @Body() RestaurantRequestDto _);

  @GET('')
  Future<List<DetailedRestaurantResponseDto>> getAll();

  @GET('/restaurateur')
  Future<DetailedRestaurantResponseDto> getMyRestaurant();

  @GET('/{id}')
  Future<DetailedRestaurantResponseDto> getById(@Path() int id);
}
