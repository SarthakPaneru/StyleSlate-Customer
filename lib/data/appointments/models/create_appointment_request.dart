import 'package:json_annotation/json_annotation.dart';

part 'create_appointment_request.g.dart';

@JsonSerializable()
class CreateAppointmentRequest {
  const CreateAppointmentRequest({
    required this.bookingStart,
    required this.bookingEnd,
    required this.barberId,
    required this.servicesIds,
  });

  final int bookingStart;
  final int bookingEnd;
  final int barberId;
  final List<String> servicesIds;

  Map<String, dynamic> toJson() => _$CreateAppointmentRequestToJson(this);
}
