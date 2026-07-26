import 'package:json_annotation/json_annotation.dart';

part 'service_model.g.dart';

@JsonSerializable()
class ServiceModel {
  const ServiceModel({
    required this.id,
    required this.serviceName,
    required this.fee,
    required this.serviceTimeInMinutes,
  });

  final int id;
  final String serviceName;
  final String fee;
  final String serviceTimeInMinutes;

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);
}
