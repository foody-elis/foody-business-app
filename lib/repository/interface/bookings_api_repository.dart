import 'package:dio/dio.dart';
import 'package:foody_business_app/dto/response/booking_response_dto.dart';
import 'package:retrofit/http.dart';

import '../../dto/request/booking_request_dto.dart';

part '../generated/interface/bookings_api_repository.g.dart';

@RestApi()
abstract class BookingsApiRepository {
  factory BookingsApiRepository(Dio dio, {String? baseUrl}) =
      _BookingsApiRepository;

  @GET('/restaurant/{id}')
  Future<List<BookingResponseDto>> getByRestaurant(@Path() int id);

  @GET('/customer')
  Future<List<BookingResponseDto>> getByCustomer();

  @POST('')
  Future<BookingResponseDto> save(@Body() BookingRequestDto _);

  @PATCH('/cancel/{id}')
  Future<BookingResponseDto> cancel(@Path() int id);
}
