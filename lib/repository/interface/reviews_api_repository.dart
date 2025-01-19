import 'package:dio/dio.dart';
import 'package:foody_business_app/dto/request/review_request_dto.dart';
import 'package:foody_business_app/dto/response/review_response_dto.dart';
import 'package:retrofit/http.dart';

part '../generated/interface/reviews_api_repository.g.dart';

@RestApi()
abstract class ReviewsApiRepository {
  factory ReviewsApiRepository(Dio dio, {String? baseUrl}) =
      _ReviewsApiRepository;

  @GET('/restaurant/{id}')
  Future<List<ReviewResponseDto>> getByRestaurant(@Path() int id);

  @GET('/customer')
  Future<List<ReviewResponseDto>> getByCustomer();

  @POST('')
  Future<ReviewResponseDto> save(@Body() ReviewRequestDto _);
}
