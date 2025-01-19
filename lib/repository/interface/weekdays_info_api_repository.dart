import 'package:dio/dio.dart';
import 'package:foody_business_app/dto/request/weekday_info_request_dto.dart';
import 'package:foody_business_app/dto/request/weekday_info_update_request_dto.dart';
import 'package:foody_business_app/dto/response/weekday_info_response_dto.dart';
import 'package:retrofit/http.dart';

part '../generated/interface/weekdays_info_api_repository.g.dart';

@RestApi()
abstract class WeekdaysInfoApiRepository {
  factory WeekdaysInfoApiRepository(Dio dio, {String? baseUrl}) =
      _WeekdaysInfoApiRepository;

  @POST('')
  Future<WeekdayInfoResponseDto> save(@Body() WeekdayInfoRequestDto _);

  @GET('/restaurant/{id}')
  Future<List<WeekdayInfoResponseDto>> getByRestaurant(@Path() int id);

  @PUT('/{id}')
  Future<WeekdayInfoResponseDto> update(
      @Path() int id, @Body() WeekdayInfoUpdateRequestDto _);
}
