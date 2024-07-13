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
  List<int> _barberIds = [];
  List<int> ids = [];
  int _lengthOfResponse = 0;
  bool isLoading = true;

  // New lists for each tab
  List<Map<String, dynamic>> upcomingAppointments = [];
  List<Map<String, dynamic>> completedAppointments = [];
  List<Map<String, dynamic>> cancelledAppointments = [];

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

      // Populate the appropriate list based on the status
      List<Map<String, dynamic>> appointmentList = [];
      for (int i = 0; i < _lengthOfResponse; i++) {
        appointmentList.add({
          'barberName': _barberNames[i],
          'userId': _userIds[i],
          'imageUrl': _imageUrls[i],
          'date': _dates[i],
          'time': _times[i],
          'serviceName': _serviceNames[i],
          'barberId': _barberIds[i],
          'id': ids[i]
        });
      }

      setState(() {
        switch (status) {
          case "upcoming":
            upcomingAppointments = appointmentList;
            break;
          case "completed":
            completedAppointments = appointmentList;
            break;
          case "cancelled":
            cancelledAppointments = appointmentList;
            break;
        }
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
    _barberIds.clear();
  }

  Future<void> getAppointment(dynamic response) async {
    Map<String, dynamic> jsonResponseAppointment = response;
    final bookingStart = jsonResponseAppointment['bookingStart'];
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(bookingStart * 1000);

    _dates.add(DateFormat('yyyy-MM-dd').format(dateTime));
    _times.add(DateFormat('HH:mm').format(dateTime));

    ids.add(jsonResponseAppointment['id']);
    Map<String, dynamic> barber = jsonResponseAppointment['barber'];
    _barberIds.add(barber['id']);
    Map<String, dynamic> user = barber['user'];
    _userIds.add(user['id']);

    _barberNames.add('${user['firstName']} ${user['lastName']}');

    Map<String, dynamic> service = jsonResponseAppointment['services'][0];
    _serviceNames.add(service['serviceName']);
  }

  Future<void> cancelAppointment(
      int index, int appointmentId, String status) async {
    print('AppointmentId: $appointmentId');
    await _apiRequests.updateAppointmentStatus(appointmentId, status);
    setState(() {
      Map<String, dynamic> appointmentToCancel =
          upcomingAppointments.removeAt(index);
      cancelledAppointments.add(appointmentToCancel);
    });

    // TODO: Implement API call to update the appointment status in the database
    // await _apiRequests.updateAppointmentStatus(appointmentId, "CANCELLED");

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('Appointment cancelled successfully'),
    //     behavior: SnackBarBehavior.floating,
    //     margin: EdgeInsets.only(
    //       bottom: MediaQuery.of(context).size.height - 100,
    //       left: 20,
    //       right: 20,
    //     ),
    //   ),
    // );
  }

  Future<void> completeAppointment(
      int index, int appointmentId, String status) async {
    _apiRequests.updateAppointmentStatus(appointmentId, status);
    setState(() {
      Map<String, dynamic> appointmentToComplete =
          upcomingAppointments.removeAt(index);
      completedAppointments.add(appointmentToComplete);
    });

    // TODO: Implement API call to update the appointment status in the database
    // await _apiRequests.updateAppointmentStatus(appointmentId, "COMPLETED");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Appointment completed successfully'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 100,
          left: 20,
          right: 20,
        ),
      ),
    );
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
          _buildAppointmentList(upcomingAppointments),
          _buildAppointmentList(completedAppointments),
          _buildAppointmentList(cancelledAppointments),
        ],
      ),
    );
  }

  Widget _buildAppointmentList(List<Map<String, dynamic>> appointments) {
    return RefreshIndicator(
      onRefresh: () async {
        await getAppointments(_getStatusForCurrentTab());
      },
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.deepPurpleAccent))
          : appointments.isEmpty
              ? Center(
                  child: Text(
                    'No appointments',
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    return _buildAppointmentCard(appointments[index], index);
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

  Widget _buildAppointmentCard(Map<String, dynamic> appointment, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff2A2D3E), Color(0xff3E4259)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
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
                        CachedNetworkImageProvider(appointment['imageUrl']),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment['barberName'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          appointment['serviceName'],
                          style: const TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.w500,
                          ),
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
                  _buildInfoChip(Icons.calendar_today, appointment['date']),
                  _buildInfoChip(Icons.access_time, appointment['time']),
                ],
              ),
              const SizedBox(height: 16),
              if (_tabController.index == 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      icon: Icons.check_circle,
                      label: 'Complete',
                      color: Colors.green,
                      onPressed: () => completeAppointment(
                          index, appointment['id'], 'COMPLETED'),
                    ),
                    _buildActionButton(
                      icon: Icons.cancel,
                      label: 'Cancel',
                      color: Colors.red,
                      onPressed: () => cancelAppointment(
                          index, appointment['id'], 'CANCELLED'),
                    ),
                  ],
                )
              else if (_tabController.index == 1)
                Center(
                  child: _buildInfoChip(Icons.check_circle, 'Completed',
                      color: Colors.green),
                )
              else
                Center(
                  child: _buildInfoChip(Icons.cancel, 'Cancelled',
                      color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label,
      {Color color = Colors.white70}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          SizedBox(width: 6),
          Text(label, style: TextStyle(color: color)),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon, color: Colors.white),
      label: Text(label),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
