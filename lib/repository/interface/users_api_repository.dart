import 'package:dio/dio.dart';
import 'package:foody_business_app/dto/request/user_update_request_dto.dart';
import 'package:foody_business_app/dto/response/user_response_dto.dart';
import 'package:retrofit/http.dart';

part '../generated/interface/users_api_repository.g.dart';

@RestApi()
abstract class UsersApiRepository {
  factory UsersApiRepository(Dio dio, {String? baseUrl}) = _UsersApiRepository;

  @GET('/{id}')
  Future<UserResponseDto> getById(@Path() int id);

  @PUT('')
  Future<UserResponseDto> edit(@Body() UserUpdateRequestDto _);
}
