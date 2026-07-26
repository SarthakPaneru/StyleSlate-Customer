// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_forgot_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmForgotPasswordRequest _$ConfirmForgotPasswordRequestFromJson(
  Map<String, dynamic> json,
) => ConfirmForgotPasswordRequest(
  email: json['email'] as String,
  newPassword: json['newPassword'] as String,
  confirmNewPassword: json['confirmNewPassword'] as String,
  otp: json['otp'] as String,
);

Map<String, dynamic> _$ConfirmForgotPasswordRequestToJson(
  ConfirmForgotPasswordRequest instance,
) => <String, dynamic>{
  'email': instance.email,
  'newPassword': instance.newPassword,
  'confirmNewPassword': instance.confirmNewPassword,
  'otp': instance.otp,
};
