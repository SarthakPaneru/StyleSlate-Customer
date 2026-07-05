import 'package:json_annotation/json_annotation.dart';

part 'service_dto.g.dart';

/// Replaces `modules/models/service.dart` (which was unreferenced by any
/// live code — parsed here from `GET /barber/get/{id}`'s nested `services`).
@JsonSerializable()
class ServiceDto {
  ServiceDto({this.id, this.serviceName, this.fee, this.serviceTimeInMinutes});

  final int? id;
  final String? serviceName;
  final String? fee;
  final String? serviceTimeInMinutes;

  factory ServiceDto.fromJson(Map<String, dynamic> json) => _$ServiceDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceDtoToJson(this);
}
