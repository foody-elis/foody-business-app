import 'package:json_annotation/json_annotation.dart';

part 'mapper/error_dto.g.dart';

@JsonSerializable()
class ErrorDto {
  const ErrorDto({
    required this.timestamp,
    required this.status,
    required this.error,
    required this.message,
    required this.path,
  });

  final DateTime timestamp;
  final int status;
  final String error;

  // String | Map<String, String>
  final Object message;
  final String path;

  factory ErrorDto.fromJson(Map<String, dynamic> json) =>
      _$ErrorDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorDtoToJson(this);
}
