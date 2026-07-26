import 'package:json_annotation/json_annotation.dart';

part 'confirm_forgot_password_request.g.dart';

@JsonSerializable()
class ConfirmForgotPasswordRequest {
  const ConfirmForgotPasswordRequest({
    required this.email,
    required this.newPassword,
    required this.confirmNewPassword,
    required this.otp,
  });

  final String email;
  final String newPassword;
  final String confirmNewPassword;
  final String otp;

  Map<String, dynamic> toJson() => _$ConfirmForgotPasswordRequestToJson(this);
}
