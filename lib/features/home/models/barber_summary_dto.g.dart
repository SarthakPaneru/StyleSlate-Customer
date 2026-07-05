// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barber_summary_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarberSummaryDto _$BarberSummaryDtoFromJson(Map<String, dynamic> json) =>
    BarberSummaryDto(
      id: (json['id'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : UserDto.fromJson(json['user'] as Map<String, dynamic>),
      distance: (json['distance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$BarberSummaryDtoToJson(BarberSummaryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'distance': instance.distance,
    };
