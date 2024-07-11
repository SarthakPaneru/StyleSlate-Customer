import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/config/api_requests.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ScheduledAppointmentPage extends StatefulWidget {
  const ScheduledAppointmentPage({Key? key}) : super(key: key);

  @override
  _ScheduledAppointmentPageState createState() =>
      _ScheduledAppointmentPageState();
}

class _ScheduledAppointmentPageState extends State<ScheduledAppointmentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ApiRequests _apiRequests = ApiRequests();
  List<String> _barberNames = [];
  List<int> _userIds = [];
  List<String> _imageUrls = [];
  List<String> _dates = [];
  List<String> _times = [];
  List<String> _serviceNames = [];
  int _lengthOfResponse = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
    getAppointments("upcoming");
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      setState(() {
        isLoading = true;
      });
      switch (_tabController.index) {
        case 0:
          getAppointments("upcoming");
          break;
        case 1:
          getAppointments("completed");
          break;
        case 2:
          getAppointments("cancelled");
          break;
      }
    }
  }

  void getImageUrl() {
    for (int i = 0; i < _lengthOfResponse; i++) {
      String image = _apiRequests.retrieveImageUrlFromUserId(_userIds[i]);
      _imageUrls.add(image);
    }
  }

  Future<void> getAppointments(String status) async {
    try {
      http.Response response = await _apiRequests.getAppointments(status);
      List<dynamic> jsonResponse = jsonDecode(response.body);
      _lengthOfResponse = jsonResponse.length;
      clearLists();
      for (var appointment in jsonResponse) {
        await getAppointment(appointment);
      }
      getImageUrl();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error getting appointments: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void clearLists() {
    _barberNames.clear();
    _userIds.clear();
    _imageUrls.clear();
    _dates.clear();
    _times.clear();
    _serviceNames.clear();
  }

  Future<void> getAppointment(dynamic response) async {
    Map<String, dynamic> jsonResponseAppointment = response;
    final bookingStart = jsonResponseAppointment['bookingStart'];
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(bookingStart * 1000);

    _dates.add(DateFormat('yyyy-MM-dd').format(dateTime));
    _times.add(DateFormat('HH:mm').format(dateTime));

    Map<String, dynamic> barber = jsonResponseAppointment['barber'];
    Map<String, dynamic> user = barber['user'];
    _userIds.add(user['id']);

    _barberNames.add('${user['firstName']} ${user['lastName']}');

    Map<String, dynamic> service = jsonResponseAppointment['services'][0];
    _serviceNames.add(service['serviceName']);
  }

  Future<void> cancelAppointment(int index) async {
    // Implement your cancel logic here
    setState(() {
      _barberNames.removeAt(index);
      _userIds.removeAt(index);
      _imageUrls.removeAt(index);
      _dates.removeAt(index);
      _times.removeAt(index);
      _serviceNames.removeAt(index);
      _lengthOfResponse--;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1E1E2E),
      appBar: AppBar(
        title: const Text(
          'My Appointments',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xff2A2D3E),
        elevation: 0,
        bottom: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          indicatorColor: Colors.deepPurpleAccent,
          controller: _tabController,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAppointmentList(),
          _buildAppointmentList(),
          _buildAppointmentList(),
        ],
      ),
    );
  }

  Widget _buildAppointmentList() {
    return RefreshIndicator(
      onRefresh: () async {
        await getAppointments(_getStatusForCurrentTab());
      },
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.deepPurpleAccent))
          : _lengthOfResponse == 0
              ? Center(
                  child: Text(
                    'No appointments',
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: _lengthOfResponse,
                  itemBuilder: (context, index) {
                    return _buildAppointmentCard(index);
                  },
                ),
    );
  }

  String _getStatusForCurrentTab() {
    switch (_tabController.index) {
      case 0:
        return "upcoming";
      case 1:
        return "completed";
      case 2:
        return "cancelled";
      default:
        return "upcoming";
    }
  }

  Widget _buildAppointmentCard(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: const Color(0xff2A2D3E),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        CachedNetworkImageProvider(_imageUrls[index]),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _barberNames[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _serviceNames[index],
                          style:
                              const TextStyle(color: Colors.deepPurpleAccent),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoChip(Icons.calendar_today, _dates[index]),
                  _buildInfoChip(Icons.access_time, _times[index]),
                  if (_tabController.index == 0)
                    ElevatedButton(
                      onPressed: () => cancelAppointment(index),
                      child: Text('Cancel'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    )
                  else if (_tabController.index == 1)
                    _buildInfoChip(Icons.check_circle, 'Completed',
                        color: Colors.green)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label,
      {Color color = Colors.white70}) {
    return Chip(
      avatar: Icon(icon, size: 16, color: color),
      label: Text(label, style: TextStyle(color: color)),
      backgroundColor: Colors.black12,
    );
  }
}
