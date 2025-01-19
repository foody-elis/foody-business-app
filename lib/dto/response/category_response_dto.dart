import 'package:json_annotation/json_annotation.dart';

part '../mapper/response/category_response_dto.g.dart';

@JsonSerializable()
class CategoryResponseDto {
  const CategoryResponseDto({required this.id, required this.name});

  factory CategoryResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseDtoFromJson(json);

  final int id;
  final String name;

  Map<String, dynamic> toJson() => _$CategoryResponseDtoToJson(this);
}
