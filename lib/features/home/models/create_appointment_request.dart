import 'package:json_annotation/json_annotation.dart';

part 'create_appointment_request.g.dart';

@JsonSerializable()
class CreateAppointmentRequest {
  CreateAppointmentRequest({
    required this.bookingStart,
    required this.bookingEnd,
    required this.barberId,
    required this.servicesIds,
  });

  final int bookingStart;
  final int bookingEnd;
  final int barberId;
  final List<String> servicesIds;

  factory CreateAppointmentRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateAppointmentRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateAppointmentRequestToJson(this);
}
