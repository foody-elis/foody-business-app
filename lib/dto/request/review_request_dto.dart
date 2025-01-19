import 'package:json_annotation/json_annotation.dart';

part '../mapper/request/review_request_dto.g.dart';

@JsonSerializable()
class ReviewRequestDto {
  const ReviewRequestDto({
    required this.title,
    required this.description,
    required this.rating,
    required this.restaurantId,
    this.dishId,
  });

  factory ReviewRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ReviewRequestDtoFromJson(json);

  final String title;

  final String description;

  final int rating;

  final int restaurantId;

  final int? dishId;

  Map<String, dynamic> toJson() => _$ReviewRequestDtoToJson(this);
}
