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
  });

  final String email;
  final String password;
  final String confirmPassword;
  final String firstName;
  final String lastName;

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
