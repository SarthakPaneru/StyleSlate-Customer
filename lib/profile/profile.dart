import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/config/api_requests.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ApiRequests _apiRequests = ApiRequests();
  File? _image;

  String _imageUrl = '';
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImageUrl();
  }

  Future<void> getImageUrl() async {
    String image = await _apiRequests.retrieveImageUrl();
    setState(() {
      _imageUrl = image;
      print(_imageUrl);
    });
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
                child: Image.network(_imageUrl),
              ),
              ElevatedButton(
                onPressed: getImage,
                child: const Text('Edit Profile Picture'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
