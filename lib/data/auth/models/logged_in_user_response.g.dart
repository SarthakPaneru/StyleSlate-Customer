// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logged_in_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
  id: (json['id'] as num).toInt(),
  email: json['email'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  phone: json['phone'] as String?,
);

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
    };

LoggedInUserResponse _$LoggedInUserResponseFromJson(
  Map<String, dynamic> json,
) => LoggedInUserResponse(
  id: (json['id'] as num).toInt(),
  user: UserResponse.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LoggedInUserResponseToJson(
  LoggedInUserResponse instance,
) => <String, dynamic>{'id': instance.id, 'user': instance.user};
