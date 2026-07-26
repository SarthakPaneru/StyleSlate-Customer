// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) => ServiceModel(
  id: (json['id'] as num).toInt(),
  serviceName: json['serviceName'] as String,
  fee: json['fee'] as String,
  serviceTimeInMinutes: json['serviceTimeInMinutes'] as String,
);

Map<String, dynamic> _$ServiceModelToJson(ServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serviceName': instance.serviceName,
      'fee': instance.fee,
      'serviceTimeInMinutes': instance.serviceTimeInMinutes,
    };
