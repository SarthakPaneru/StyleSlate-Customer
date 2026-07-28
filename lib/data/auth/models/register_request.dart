import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  const RegisterRequest({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.firstName,
    required this.lastName,
    required this.phone,
  });

  final String email;
  final String password;
  final String confirmPassword;
  final String firstName;
  final String lastName;
  final String phone;

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
