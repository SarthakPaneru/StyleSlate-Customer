import 'package:hamro_barber_mobile/features/auth/models/customer_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appointment_dto.g.dart';

@JsonSerializable()
class AppointmentServiceDto {
  AppointmentServiceDto({this.serviceName});

  final String? serviceName;

  factory AppointmentServiceDto.fromJson(Map<String, dynamic> json) =>
      _$AppointmentServiceDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AppointmentServiceDtoToJson(this);
}

@JsonSerializable()
class AppointmentBarberDto {
  AppointmentBarberDto({this.user});

  final UserDto? user;

  factory AppointmentBarberDto.fromJson(Map<String, dynamic> json) =>
      _$AppointmentBarberDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AppointmentBarberDtoToJson(this);
}

/// Response shape of `GET /appointment/get/customer/{customerId}`, replacing
/// the manual `jsonDecode` parsing in `Screen/appointment.dart`.
@JsonSerializable()
class AppointmentDto {
  AppointmentDto({this.bookingStart, this.barber, this.services});

  final int? bookingStart;
  final AppointmentBarberDto? barber;
  final List<AppointmentServiceDto>? services;

  factory AppointmentDto.fromJson(Map<String, dynamic> json) => _$AppointmentDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AppointmentDtoToJson(this);
}
