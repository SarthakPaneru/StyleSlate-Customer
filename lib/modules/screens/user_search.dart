import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/config/api_requests.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class UserSearch extends StatefulWidget {
  const UserSearch({super.key});

  @override
  State<UserSearch> createState() => _FavourtiePageState();
}

class _FavourtiePageState extends State<UserSearch> {
  final ApiRequests _apiRequests = ApiRequests();
  String data = '';
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://192.168.1.101:8080/ws'),
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  Future<void> getData() async {
    http.Response response = await _apiRequests.getData();
    final a = jsonDecode(response.body);
    data = a['a'];
    print('Hello socket: ' '${response.statusCode}');
    print('Data: ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Text(
            "Cancel",
            style: TextStyle(color: Colors.white),
          )
        ],
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
      itemCount: 1,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Card(
            elevation: 2.0,
            color:
                const Color(0xff323345), // Set the card background color here
            child: ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/stylist2.png'),
              ),
              title: Text(
                data,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              subtitle: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Location: Satdobato',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              trailing: isCompleted
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : IconButton(
                      icon: const Icon(Icons.cancel),
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
