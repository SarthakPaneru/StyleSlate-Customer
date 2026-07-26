// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_appointment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAppointmentRequest _$CreateAppointmentRequestFromJson(
  Map<String, dynamic> json,
) => CreateAppointmentRequest(
  bookingStart: (json['bookingStart'] as num).toInt(),
  bookingEnd: (json['bookingEnd'] as num).toInt(),
  barberId: (json['barberId'] as num).toInt(),
  servicesIds: (json['servicesIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$CreateAppointmentRequestToJson(
  CreateAppointmentRequest instance,
) => <String, dynamic>{
  'bookingStart': instance.bookingStart,
  'bookingEnd': instance.bookingEnd,
  'barberId': instance.barberId,
  'servicesIds': instance.servicesIds,
};
