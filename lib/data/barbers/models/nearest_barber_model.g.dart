// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearest_barber_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NearestBarberUser _$NearestBarberUserFromJson(Map<String, dynamic> json) =>
    NearestBarberUser(
      id: (json['id'] as num).toInt(),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );

Map<String, dynamic> _$NearestBarberUserToJson(NearestBarberUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };

NearestBarberModel _$NearestBarberModelFromJson(Map<String, dynamic> json) =>
    NearestBarberModel(
      id: (json['id'] as num).toInt(),
      distance: (json['distance'] as num).toDouble(),
      user: NearestBarberUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NearestBarberModelToJson(NearestBarberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'distance': instance.distance,
      'user': instance.user,
    };
