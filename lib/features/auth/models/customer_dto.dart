import 'package:json_annotation/json_annotation.dart';

part 'customer_dto.g.dart';

@JsonSerializable()
class UserDto {
  UserDto({this.id, this.email, this.phone, this.firstName, this.lastName});

  final int? id;
  final String? email;
  final String? phone;
  final String? firstName;
  final String? lastName;

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}

/// Response shape of `GET /customer/get-logged-in-user`, replacing the
/// map-based parsing in `core/auth/customer.dart` / `modules/models/user.dart`.
@JsonSerializable()
class CustomerDto {
  CustomerDto({this.id, this.user});

  final int? id;
  final UserDto? user;

  factory CustomerDto.fromJson(Map<String, dynamic> json) => _$CustomerDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerDtoToJson(this);
}
