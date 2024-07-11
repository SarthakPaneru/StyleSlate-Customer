import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/socket/socket_dto.dart';
// import 'package:stomp_dart_client/stomp.dart';
// import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
// import 'package:stomp_dart_client/stomp_frame.dart';

class ChatPage extends StatefulWidget {
  final int id;
  final double longitude;
  final double latitude;

  ChatPage(this.id, this.longitude, this.latitude);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late StompClient stompClient;
  List<MessageData> msglist = [];
  TextEditingController msgtext = TextEditingController();
  bool connected = false;
  SocketDto socketDto = SocketDto();

  @override
  void initState() {
    super.initState();

    socketDto.customerId = widget.id as int?;
    socketDto.latitude = widget.latitude;
    socketDto.longitude = widget.longitude;

    // Initialize the StompClient
    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://192.168.18.3:8080/ws', // Ensure this URL is correct
        onConnect: onConnect,
        beforeConnect: () async {
          print('Waiting to connect...');
          await Future.delayed(const Duration(milliseconds: 200));
          print('Connecting...');
        },
        onWebSocketError: (dynamic error) {
          print('WebSocket error: $error');
        },
        onStompError: (dynamic error) {
          print('STOMP error: $error');
        },
        onDisconnect: (frame) {
          print('Disconnected: ${frame.body}');
          setState(() {
            connected = false;
          });
        },
        // onConnectError: (dynamic error) {
        //   print('Connect error: $error');
        // },
        // stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
        // webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
      ),
    );

    // Activate the StompClient
    stompClient.activate();
  }

  void onConnect(StompFrame frame) {
    setState(() {
      connected = true;
    });

    stompClient.subscribe(
      destination: '/topic/customer/${widget.id}',
      callback: (frame) {
        if (frame.body != null) {
          Map<String, dynamic> result = json.decode(frame.body!);
          print(result);

          setState(() {
            msglist.add(MessageData(
              msgtext: result['text'],
              userid: result['from'],
              isme: result['from'] == "myid", // Adjust as per your ID logic
            ));
          });
        }
      },
    );

    // This is just for testing purposes
    // Timer.periodic(const Duration(seconds: 5), (_) {
    //   stompClient.send(
    //     destination: '/topic/receive/${widget.id}',
    //     body: json.encode({'from': 'myid', 'text': 'Hello!'}),
    //   );
    // });
  }

  @override
  void dispose() {
    stompClient.deactivate();
    super.dispose();
  }

  List<String> items = ["Breard", "Haircut"];
  List<int> prices = [100, 200];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff323345),
      appBar: AppBar(
        backgroundColor: const Color(0xff323345),
        title: Center(
            child: Text(
          'Chat with ${widget.id}',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(16.0),
                  margin: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        items[index],
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              print(" ${prices[index]}");
                              stompClient.send(
                                destination: '/app/customer/${widget.id}',
                                body: json.encode(socketDto.asMap()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green, // text color
                            ),
                            child: Text(prices[index].toString()),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (connected)
            if (!connected)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Disconnected from WebSocket'),
              ),
        ],
      ),
    );
  }
}

class MessageData {
  String msgtext, userid;
  bool isme;

  MessageData({
    required this.msgtext,
    required this.userid,
    required this.isme,
  });
}
