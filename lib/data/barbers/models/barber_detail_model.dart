import 'package:json_annotation/json_annotation.dart';
import 'service_model.dart';

part 'barber_detail_model.g.dart';

@JsonSerializable()
class BarberDetailModel {
  const BarberDetailModel({
    required this.panNo,
    required this.phone,
    required this.name,
    required this.rating,
    required this.services,
  });

  final String panNo;
  final String? phone;
  final String name;
  final double rating;
  final List<ServiceModel> services;

  factory BarberDetailModel.fromJson(Map<String, dynamic> json) =>
      _$BarberDetailModelFromJson(json);
}
