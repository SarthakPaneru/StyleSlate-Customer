import 'package:hamro_barber_mobile/features/home/models/service_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'barber_detail_dto.g.dart';

/// Response shape of `GET /barber/get/{barberId}`, replacing the manual
/// `jsonDecode` parsing in `Screen/detailScreen.dart`.
@JsonSerializable()
class BarberDetailDto {
  BarberDetailDto({this.panNo, this.phone, this.name, this.rating, this.services});

  final String? panNo;
  final String? phone;
  final String? name;
  final double? rating;
  final List<ServiceDto>? services;

  factory BarberDetailDto.fromJson(Map<String, dynamic> json) => _$BarberDetailDtoFromJson(json);
  Map<String, dynamic> toJson() => _$BarberDetailDtoToJson(this);
}
