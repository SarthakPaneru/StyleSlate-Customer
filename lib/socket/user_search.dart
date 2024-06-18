import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/config/api_requests.dart';
import 'package:hamro_barber_mobile/core/auth/customer.dart';
import 'package:http/http.dart' as http;
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatPage extends StatefulWidget {
  ChatPage(this.id);
  // ChatPage({super.key, required this.id});

  final String id;

  @override
  State<StatefulWidget> createState() {
    return ChatPageState(id);
  }
}

class ChatPageState extends State<ChatPage> {
  late IOWebSocketChannel channel; //channel variable for websocket
  late bool connected; // boolean value to track connection status

  String myid = "1234"; //my id
  String recieverid = "4321"; //reciever id
  // swap myid and recieverid value on another mobile to test send and recieve
  String auth = "addauthkeyifrequired"; //auth key

  List<MessageData> msglist = [];

  TextEditingController msgtext = TextEditingController();

  late StompClient stompClient;
  final String id;

  ChatPageState(this.id);

  @override
  void initState() {
    connected = false;
    msgtext.text = "";

    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://172.16.12.211:8080/ws',
        onConnect: onConnect,
        beforeConnect: () async {
          print('waiting to connect...');
          print(id);
          await Future.delayed(const Duration(milliseconds: 200));
          print('connecting...');
        },
        onWebSocketError: (dynamic error) => print(error.toString()),
        stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
        webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
      ),
    );

    stompClient.activate();

    super.initState();
  }

  void onConnect(StompFrame frame) {
    stompClient.subscribe(
      destination: '/topic/$id',
      callback: (frame) {
        Map<String, dynamic>? result = json.decode(frame.body!);
        print(result);
      },
    );

    Timer.periodic(const Duration(seconds: 5), (_) {
      stompClient.send(
        destination: '/topic/test',
        body: json.encode({'a': 123}),
      );
      print('PERIODIC');
    });
  }

  @override
  void dispose() {
    stompClient.deactivate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class MessageData {
  //message data model
  String msgtext, userid;
  bool isme;
  MessageData(
      {required this.msgtext, required this.userid, required this.isme});
}
