// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceDto _$ServiceDtoFromJson(Map<String, dynamic> json) => ServiceDto(
  id: (json['id'] as num?)?.toInt(),
  serviceName: json['serviceName'] as String?,
  fee: json['fee'] as String?,
  serviceTimeInMinutes: json['serviceTimeInMinutes'] as String?,
);

Map<String, dynamic> _$ServiceDtoToJson(ServiceDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serviceName': instance.serviceName,
      'fee': instance.fee,
      'serviceTimeInMinutes': instance.serviceTimeInMinutes,
    };
