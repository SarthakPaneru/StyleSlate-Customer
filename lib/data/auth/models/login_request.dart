import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  const LoginRequest({
    required this.email,
    required this.password,
    this.userRole = 'CUSTOMER',
  });

  final String email;
  final String password;
  final String userRole;

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
