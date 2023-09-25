import 'package:flutter/material.dart';

class FavourtiePage extends StatefulWidget {
  @override
  State<FavourtiePage> createState() => _FavourtiePageState();
}

class _FavourtiePageState extends State<FavourtiePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favourtie Barbers',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: _buildAppointmentList(false),
    );
  }

  Widget _buildAppointmentList(bool isCompleted) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Card(
            elevation: 2.0,
            child: ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/stylist2.png'),
              ),
              title: const Text(
                'Bhoj Raj Mishra',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text('Location: Satdobato'),
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
