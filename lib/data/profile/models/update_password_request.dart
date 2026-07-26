import 'package:json_annotation/json_annotation.dart';

part 'update_password_request.g.dart';

@JsonSerializable()
class UpdatePasswordRequest {
  const UpdatePasswordRequest({
    required this.email,
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  final String email;
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;

  Map<String, dynamic> toJson() => _$UpdatePasswordRequestToJson(this);
}
