import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/config/api_requests.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ApiRequests _apiRequests = ApiRequests();
  File? _image;

  void fetchData() async {
    http.Response response = await _apiRequests.getLoggedInCustomer();
    List<dynamic> jsonResponse = jsonDecode(response.body);
    // String barber = jsonResponse['name'];
    _image = response.body as File?;
    // print(stylistData1);

    // setState(() {
    //   _isLoading = false;
    // });
  }

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _apiRequests.uploadImage(_image!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? Icon(
                        Icons.person,
                        size: 80,
                      )
                    : null,
              ),
              ElevatedButton(
                onPressed: getImage,
                child: Text('Edit Profile Picture'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
