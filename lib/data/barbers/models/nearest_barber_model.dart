import 'package:json_annotation/json_annotation.dart';

part 'nearest_barber_model.g.dart';

@JsonSerializable()
class NearestBarberUser {
  const NearestBarberUser({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  final int id;
  final String firstName;
  final String lastName;

  factory NearestBarberUser.fromJson(Map<String, dynamic> json) =>
      _$NearestBarberUserFromJson(json);
}

@JsonSerializable()
class NearestBarberModel {
  const NearestBarberModel({
    required this.id,
    required this.distance,
    required this.user,
  });

  final int id;
  final double distance;
  final NearestBarberUser user;

  String get fullName => '${user.firstName} ${user.lastName}';

  factory NearestBarberModel.fromJson(Map<String, dynamic> json) =>
      _$NearestBarberModelFromJson(json);
}
