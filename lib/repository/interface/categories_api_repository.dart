import 'package:dio/dio.dart';
import 'package:foody_business_app/dto/response/category_response_dto.dart';
import 'package:retrofit/http.dart';

part '../generated/interface/categories_api_repository.g.dart';

@RestApi()
abstract class CategoriesApiRepository {
  factory CategoriesApiRepository(Dio dio, {String? baseUrl}) =
      _CategoriesApiRepository;

  @GET('')
  Future<List<CategoryResponseDto>> getAll();
}
