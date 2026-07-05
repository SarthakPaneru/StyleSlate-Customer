import 'package:hamro_barber_mobile/features/auth/models/customer_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'barber_summary_dto.g.dart';

/// Response shape of `GET /barber/get/nearest`, replacing the manual
/// `jsonDecode` parsing in `widgets/barberSelection.dart`.
@JsonSerializable()
class BarberSummaryDto {
  BarberSummaryDto({this.id, this.user, this.distance});

  final int? id;
  final UserDto? user;
  final double? distance;

  factory BarberSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$BarberSummaryDtoFromJson(json);
  Map<String, dynamic> toJson() => _$BarberSummaryDtoToJson(this);
}
