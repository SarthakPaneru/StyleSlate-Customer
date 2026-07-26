// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barber_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarberDetailModel _$BarberDetailModelFromJson(Map<String, dynamic> json) =>
    BarberDetailModel(
      panNo: json['panNo'] as String,
      phone: json['phone'] as String?,
      name: json['name'] as String,
      rating: (json['rating'] as num).toDouble(),
      services: (json['services'] as List<dynamic>)
          .map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BarberDetailModelToJson(BarberDetailModel instance) =>
    <String, dynamic>{
      'panNo': instance.panNo,
      'phone': instance.phone,
      'name': instance.name,
      'rating': instance.rating,
      'services': instance.services,
    };
