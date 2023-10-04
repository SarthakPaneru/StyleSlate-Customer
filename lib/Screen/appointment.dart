import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/config/api_requests.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ScheduledAppointmentPage extends StatefulWidget {
  @override
  _ScheduledAppointmentPageState createState() =>
      _ScheduledAppointmentPageState();
}

class _ScheduledAppointmentPageState extends State<ScheduledAppointmentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ApiRequests _apiRequests = ApiRequests();
  bool isCompleted = false;
  List<String> _barberNames = List.empty(growable: true);
  List<int> _userIds = List.empty(growable: true);
  List<String> _imageUrls = List.empty(growable: true);
  List<String> _dates = List.empty(growable: true);
  List<String> _times = List.empty(growable: true);
  List<String> _serviceNames = List.empty(growable: true);
  int _lengthOfResponse = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getAppointments("upcoming");
    _tabController = TabController(length: 3, vsync: this);
  }

  void getImageUrl() {
    for (int i = 0; i < _lengthOfResponse; i++) {
      String image = _apiRequests.retrieveImageUrlFromUserId(_userIds[i]);
      print('Image URL: $image');
      _imageUrls.add(image);
    }
    // setState(() {
    //   isLoading = false;
    // });
  }

  Future<void> getAppointments(String status) async {
    try {
      http.Response response = await _apiRequests.getAppointments(status);
      List<dynamic> jsonResponse = jsonDecode(response.body);
      _lengthOfResponse = jsonResponse.length;
      print('Length of response: $_lengthOfResponse');
      for (int i = 0; i < _lengthOfResponse; i++) {
        getAppointment(jsonResponse[i]);
      }
      getImageUrl();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error decoding JSON: $e');
    }
  }

  Future<void> getAppointment(final response) async {
    Map<String, dynamic> jsonResponseAppointment =
        jsonDecode(jsonEncode(response));
    final bookingStart = jsonResponseAppointment['bookingStart'];
    print('Booking start: $bookingStart');
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(bookingStart * 1000);
    print('DateTime: ${dateTime.toLocal()}');
    print('DateTime: ${dateTime}');

    final date = DateFormat('yyyy-MM-dd').format(dateTime);
    _dates.add(date);
    final time = DateFormat('HH:mm').format(dateTime);
    _times.add(time);

    Map<String, dynamic> barber = jsonResponseAppointment['barber'];
    Map<String, dynamic> jsonResponseBarber = jsonDecode(jsonEncode(barber));

    Map<String, dynamic> user = jsonResponseBarber['user'];
    _userIds.add(user['id']);

    Map<String, dynamic> jsonResponseUser = jsonDecode(jsonEncode(user));

    final barberName =
        '${jsonResponseUser['firstName']} ${jsonResponseUser['lastName']}';
    _barberNames.add(barberName);

    Map<String, dynamic> service = jsonResponseAppointment['services'][0];
    final serviceName = service['serviceName'];
    _serviceNames.add(serviceName);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff323345),
      appBar: AppBar(
        title: const Text(
          'Scheduled Appointments',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff323345),
        bottom: TabBar(
          labelColor: Colors.white,
          controller: _tabController,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
          ],
          onTap: (value) => setState(() async {
            switch (value) {
              case 0:
                isCompleted = false;
                await getAppointments("upcoming");
                break;

              case 1:
                isCompleted = true;
                await getAppointments("completed");
                break;

              case 2:
                isCompleted = true;
                await getAppointments("cancelled");
                break;

              default:
                break;
            }
          }),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAppointmentList(false), // Upcoming Appointments
          _buildAppointmentList(true), // Completed Appointments
          _buildAppointmentList(false)
        ],
      ),
    );
  }

  Widget _buildAppointmentList(bool isCompleted) {
    return Scaffold(
        backgroundColor: const Color(0xff323345),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _lengthOfResponse,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Card(
                      color: Color(0xff323345),
                      elevation: 2.0,
                      child: ListTile(
                        leading: CircleAvatar(
                          child: 
                          CachedNetworkImage(imageUrl: _imageUrls[index]),
                        ),
                        title: Text(
                          _barberNames[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date: ${_dates[index]}',
                                style: TextStyle(color: Colors.white70)),
                            Text('Time: ${_times[index]}',
                                style: TextStyle(color: Colors.white70)),
                            Text('Service: ${_serviceNames[index]}',
                                style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                        trailing: isCompleted
                            ? Icon(Icons.check_circle, color: Colors.green)
                            : IconButton(
                                icon: Icon(Icons.cancel),
                                color: Colors.red,
                                onPressed: () {
                                  // Cancel appointment logic here
                                },
                              ),
                      ),
                    ),
                  );
                },
              ));
  }
}
