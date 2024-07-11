import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hamro_barber_mobile/config/api_requests.dart';
import 'package:hamro_barber_mobile/modules/screens/homepage.dart';
import 'package:hamro_barber_mobile/utils/khaltihome.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

import '../widgets/button.dart';
import '../widgets/config.dart';
import '../widgets/custom_appbar.dart';

class BookingPage extends StatefulWidget {
  final int barberId;
  final int serviceId;
  const BookingPage({Key? key, required this.barberId, required this.serviceId})
      : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final ApiRequests _apiRequests = ApiRequests();
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  final int _serviceTime = 60;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      backgroundColor: const Color(0xff323345),
      appBar: CustomAppBar(
        appTitle: 'Book Appointment',
        icon: FaIcon(Icons.arrow_back_ios, color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildCalendarCard(),
              const SizedBox(height: 24),
              _buildTimeSelectionSection(),
              const SizedBox(height: 32),
              _buildBookButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _tableCalendar(),
      ),
    );
  }

  Widget _buildTimeSelectionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Time',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        if (_isWeekend) _buildWeekendWarning() else _buildTimeGrid(),
      ],
    );
  }

  Widget _buildWeekendWarning() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Tuesday is not available, please select another date',
        style: TextStyle(
          fontSize: 16,
          color: Colors.red[300],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTimeGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => setState(() {
            _currentIndex = index;
            _timeSelected = true;
          }),
          child: Container(
            decoration: BoxDecoration(
              color: _currentIndex == index
                  ? Config.primaryColor
                  : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              '${index + 9}:00 ${index + 9 > 11 ? "PM" : "AM"}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _currentIndex == index ? Colors.white : Colors.white70,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBookButton() {
    return Button(
      width: double.infinity,
      title: 'Book Appointment',
      onPressed: _bookAppointment,
      disable: !(_timeSelected && _dateSelected),
    );
  }

  void _bookAppointment() {
    final desiredTime = TimeOfDay(hour: _currentIndex! + 9, minute: 0);
    final appointmentDateTime = DateTime(
      _focusDay.year,
      _focusDay.month,
      _focusDay.day,
      desiredTime.hour,
      desiredTime.minute,
    );
    int appointmentStart = appointmentDateTime.toUtc().millisecondsSinceEpoch;
    int appointmentEnd =
        appointmentStart + Duration(minutes: _serviceTime).inMilliseconds;

    _createAppointment(
        (appointmentStart ~/ 1000) as int, (appointmentEnd ~/ 1000) as int);
  }

  _createAppointment(int bookingStart, int bookingEnd) async {
    try {
      http.Response response = await _apiRequests.createAppointment(
          bookingStart, bookingEnd, widget.barberId, widget.serviceId);

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Successfully Booked'),
              content: Text('Barber has been reserved'),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return PaymentPage();
                          },
                        ),
                      );
                    },
                    child: Text("Payment")),
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return HomePage();
                        },
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      } else {
        final errorResponse = json.decode(response.body);
        _showSnackbar('Error: ${errorResponse['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      _showSnackbar('An error occurred: $e');
    }
  }

  void _showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _tableCalendar() {
    return TableCalendar(
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(2024, 12, 31),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
      calendarStyle: CalendarStyle(
        todayDecoration:
            BoxDecoration(color: Config.primaryColor, shape: BoxShape.circle),
        selectedDecoration:
            BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
        todayTextStyle: TextStyle(color: Colors.white),
        selectedTextStyle: TextStyle(color: Colors.white),
        defaultTextStyle: TextStyle(color: Colors.white70),
        weekendTextStyle: TextStyle(color: Colors.red[300]),
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
      ),
      availableCalendarFormats: const {CalendarFormat.month: 'Month'},
      onPageChanged: (focusedDay) => _focusDay = focusedDay,
      onDaySelected: _onDaySelected,
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _currentDay = selectedDay;
      _focusDay = focusedDay;
      _dateSelected = true;
      _isWeekend = selectedDay.weekday == 2;
      if (_isWeekend) {
        _timeSelected = false;
        _currentIndex = null;
      }
    });
  }
}
