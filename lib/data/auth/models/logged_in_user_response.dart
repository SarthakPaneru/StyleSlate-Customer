import 'package:json_annotation/json_annotation.dart';

part 'logged_in_user_response.g.dart';

@JsonSerializable()
class UserResponse {
  const UserResponse({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phone,
  });

  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String? phone;

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable()
class LoggedInUserResponse {
  const LoggedInUserResponse({required this.id, required this.user});

  final int id;
  final UserResponse user;

  factory LoggedInUserResponse.fromJson(Map<String, dynamic> json) =>
      _$LoggedInUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoggedInUserResponseToJson(this);
}
