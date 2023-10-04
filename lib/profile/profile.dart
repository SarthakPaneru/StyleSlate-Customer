import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/config/api_requests.dart';
import 'package:hamro_barber_mobile/constants/app_constants.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ApiRequests _apiRequests = ApiRequests();
  File? _image;
  String _imageUrl = '';

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
      height: 250,
      width: 170,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: FittedBox(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: CachedNetworkImage(
                      imageUrl: _imageUrl,
                      placeholder: (context, url) => const Icon(
                        Icons.person,
                        size: 80,
                      ),
                      fit: BoxFit.cover,
                      height: 200,
                      width: 150,
                      errorWidget: (context, url, error) => const Icon(
                        Icons
                            .person, // You can use any widget as the error placeholder
                        size: 80,
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: getImage,
                child: const Text('Edit Profile Picture'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
