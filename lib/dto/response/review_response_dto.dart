import 'package:json_annotation/json_annotation.dart';

part '../mapper/response/review_response_dto.g.dart';

@JsonSerializable()
class ReviewResponseDto {
  const ReviewResponseDto({
    required this.id,
    required this.title,
    required this.description,
    required this.rating,
    required this.restaurantId,
    required this.dishId,
    required this.customerId,
    required this.customerName,
    required this.customerSurname,
    required this.customerAvatarUrl,
    required this.createdAt,
  });

  factory ReviewResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ReviewResponseDtoFromJson(json);

  final int id;
  final String title;
  final String description;
  final int rating;
  final int restaurantId;
  final int? dishId;
  final int customerId;
  final String customerName;
  final String customerSurname;
  final String? customerAvatarUrl;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => _$ReviewResponseDtoToJson(this);
}
