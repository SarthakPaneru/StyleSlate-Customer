import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/Screen/appointment.dart';

class UserBook extends StatelessWidget {
  const UserBook({super.key});

  @override
  Widget build(BuildContext context) {
    Scaffold(backgroundColor: const Color(0xff323345));
    return ScheduledAppointmentPage();
  }
}