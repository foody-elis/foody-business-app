import 'package:dio/dio.dart';
import 'package:foody_business_app/dto/request/dish_request_dto.dart';
import 'package:foody_business_app/dto/response/dish_response_dto.dart';
import 'package:retrofit/http.dart';

part '../generated/interface/dishes_api_repository.g.dart';

@RestApi()
abstract class DishesApiRepository {
  factory DishesApiRepository(Dio dio, {String? baseUrl}) =
      _DishesApiRepository;

  @GET('/restaurant/{id}')
  Future<List<DishResponseDto>> getAllByRestaurant(@Path() int id);

  @POST('')
  Future<DishResponseDto> add(@Body() DishRequestDto _);

  @PUT('/{id}')
  Future<DishResponseDto> edit(@Path() int id, @Body() DishRequestDto _);

  @DELETE('/{id}')
  Future<void> delete(@Path() int id);
}
