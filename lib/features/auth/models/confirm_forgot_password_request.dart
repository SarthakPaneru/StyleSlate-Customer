import 'package:json_annotation/json_annotation.dart';

part 'confirm_forgot_password_request.g.dart';

@JsonSerializable()
class ConfirmForgotPasswordRequest {
  ConfirmForgotPasswordRequest({
    required this.email,
    required this.newPassword,
    required this.confirmNewPassword,
    required this.otp,
  });

  final String email;
  final String newPassword;
  final String confirmNewPassword;
  final String otp;

  factory ConfirmForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfirmForgotPasswordRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ConfirmForgotPasswordRequestToJson(this);
}
