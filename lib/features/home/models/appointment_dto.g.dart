// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentServiceDto _$AppointmentServiceDtoFromJson(
  Map<String, dynamic> json,
) => AppointmentServiceDto(serviceName: json['serviceName'] as String?);

Map<String, dynamic> _$AppointmentServiceDtoToJson(
  AppointmentServiceDto instance,
) => <String, dynamic>{'serviceName': instance.serviceName};

AppointmentBarberDto _$AppointmentBarberDtoFromJson(
  Map<String, dynamic> json,
) => AppointmentBarberDto(
  user: json['user'] == null
      ? null
      : UserDto.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AppointmentBarberDtoToJson(
  AppointmentBarberDto instance,
) => <String, dynamic>{'user': instance.user};

AppointmentDto _$AppointmentDtoFromJson(
  Map<String, dynamic> json,
) => AppointmentDto(
  bookingStart: (json['bookingStart'] as num?)?.toInt(),
  barber: json['barber'] == null
      ? null
      : AppointmentBarberDto.fromJson(json['barber'] as Map<String, dynamic>),
  services: (json['services'] as List<dynamic>?)
      ?.map((e) => AppointmentServiceDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AppointmentDtoToJson(AppointmentDto instance) =>
    <String, dynamic>{
      'bookingStart': instance.bookingStart,
      'barber': instance.barber,
      'services': instance.services,
    };
