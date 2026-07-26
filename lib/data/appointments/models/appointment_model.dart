/// The backend response for an appointment nests the barber's user object
/// and a services array (only the first entry is ever populated). This
/// shape is awkward enough that a hand-written fromJson is clearer than
/// forcing json_serializable onto it.
class AppointmentModel {
  const AppointmentModel({
    required this.bookingStart,
    required this.barberUserId,
    required this.barberName,
    required this.serviceName,
  });

  final int bookingStart;
  final int barberUserId;
  final String barberName;
  final String serviceName;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    final barber = json['barber'] as Map<String, dynamic>;
    final user = barber['user'] as Map<String, dynamic>;
    final services = json['services'] as List<dynamic>;
    final firstService = services.first as Map<String, dynamic>;

    return AppointmentModel(
      bookingStart: json['bookingStart'] as int,
      barberUserId: user['id'] as int,
      barberName: '${user['firstName']} ${user['lastName']}',
      serviceName: firstService['serviceName'] as String,
    );
  }
}
