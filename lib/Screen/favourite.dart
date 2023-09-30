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
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff323345),
      ),
      body: Container(
        color: const Color(0xff323345), // Set the background color here
        child: _buildAppointmentList(false),
      ),
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
            color: Color(0xff323345), // Set the card background color here
            child: ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/stylist2.png'),
              ),
              title: const Text(
                'SK Hair Style',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              subtitle: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text('Location: Satdobato',
                  style: TextStyle(
                    color: Colors.white
                  ),),
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
