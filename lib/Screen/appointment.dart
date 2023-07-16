import 'package:flutter/material.dart';


class ScheduledAppointmentPage extends StatefulWidget {
  @override
  _ScheduledAppointmentPageState createState() =>
      _ScheduledAppointmentPageState();
}

class _ScheduledAppointmentPageState extends State<ScheduledAppointmentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scheduled Appointments',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        bottom: TabBar(
          labelColor: Colors.black,
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
          _buildAppointmentList(false), // Upcoming Appointments
          _buildAppointmentList(true), // Completed Appointments
        ],
      ),
    );
  }

  Widget _buildAppointmentList(bool isCompleted) {
    return ListView.builder(
      itemCount: isCompleted ? 2 : 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Card(
            elevation: 2.0,
            child: ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/stylist2.png'),
              ),
              title: const Text(
                'Barber Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date: July 20, 2023'),
                  Text('Time: 10:00 AM'),
                  Text('Service: Haircut'),
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
    );
  }
}
